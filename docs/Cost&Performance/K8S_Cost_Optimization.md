# K8s Cost Optimization: Turning Down Non-Production EKS Clusters

This document explores a method for reducing costs in non-production EKS environments by automatically turning them off during non-business hours. This involves implementing a routine to shut down EKS node groups, preventing unnecessary expenses.

## Goals

- Implement a routine to turn down EKS node groups.
- Prevent unnecessary costs for non-production environments.

## Pre-POC Generic Questions

- Is this POC addressing any customer issues?
  - No.
- Are there specific requirements?
  - No.
- If related to a specific tool, are there alternative solutions?
  - Yes, there are some other tools with similar features available.
- Is there a time frame to finish the POC?
  - No.
- Do we need any investment in the POC? (licenses, expensive resources, large amount of data, time processing data, etc.)
  - No.

## Scenarios

### Shutting Down Non-Production EKS Cluster

This solution uses:

- IAM Policy for Lambda function
- Lambda function to scale EKS node groups ASG to desired values from parameters
- EventBridge rule with schedule to trigger the Lambda function

#### IAM Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:DescribeLaunchTemplateVersions",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "sns:Publish",
        "ec2:ModifyLaunchTemplate",
        "ec2:DeleteLaunchTemplateVersions",
        "ec2:CreateLaunchTemplateVersion",
        "autoscaling:PutScheduledUpdateGroupAction",
        "autoscaling:UpdateAutoScalingGroup"
      ],
      "Resource": [
        "arn:aws:autoscaling:us-east-1:481318636172:autoScalingGroup:b3cf4a0f-d697-4326-8479-af0819160939:autoScalingGroupName/eks-default_spot_group-2023050519361456430000000e-88c3f6b5-1d06-8127-25ec-be03a6230e56"
      ]
    }
  ]
}
```
#### Lambda Code

```python
import boto3
import os
import json
import datetime
from datetime import datetime, timezone, timedelta

asg = boto3.client('autoscaling')

def lambda_handler(event, context):
    parameters = json.loads(json.dumps(event))
    asg.update_auto_scaling_group(AutoScalingGroupName=parameters['asg_name'],MinSize=int(parameters['min']),DesiredCapacity=int(parameters['desired']),MaxSize=int(parameters['max']))
    
    now_utc = datetime.now(timezone.utc)
    in_01_min = now_utc + timedelta(minutes=1)
    
    print(f"""
        ASG action created
        Start time: {in_01_min}"
        Desired capacity: {parameters['desired']}
         """)
         
    response = f"""
        ASG action created
        Start time: {in_01_min}"
        Desired capacity: {parameters['desired']}
         """
```
#### Terraform Code

```hcl
 terraform {
  backend "remote" {
    organization = "vmfarms"
    workspaces {
      name = "sandbox"
    }
  }
}

resource "aws_iam_role" "cluster_turndown_lambda_role" {
  name               = "cluster_turndown_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json 

  inline_policy {
    name   = "policy-cluster_turndown_lambda_role"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions   = ["autoscaling:UpdateAutoScalingGroup"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "cluster_turndown_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "cluster_turndown_lambda"
  role          = aws_iam_role.cluster_turndown_lambda_role.arn
  handler       = "lambda.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

  environment {
    variables = {
      asg_name   = var.asg_name,
      aws_region = var.aws_region,
      desired    = "0",
      max        = "0",
      min        = "0"
    }
  }
}

module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"
  create_bus = false

  tags = {
    Name = "lambda-cluster-turndown-cron"
  }

  rules = {
    crons = {
      description         = "Trigger for a Lambda"
      schedule_expression = var.cron
    }
  }

  targets = {
    crons = [
      {
        name  = "lambda-cluster-turndown-cron"
        arn   = aws_lambda_function.cluster_turndown_lambda.arn
        input       = jsonencode(
        {
          "asg_name": "eks-default_spot_group-2023050519361456430000000e-88c3f6b5-1d06-8127-25ec-be03a6230e56",
          "min": "0",
          "max": "0",
          "desired": "0"
        }
        )
      }
    ]
  }
}
```

#### Test Payload for Lambda Function

```json
{
  "asg_name": "<asg-name",
  "min": "<asg-min-node-count-desired>",
  "max":  "<asg-max-node-count-desired>",
  "desired":  "<asg-node-count-desired>"
}
```

## Results

The POC was successful in implementing a routine for turning down non-production EKS node groups.

## Post-POC Generic Questions

- Did the POC work as expected?
  - Yes.
- Are there any additional steps before offering it as a solution to customers?
  - No.
- Are there enough information to implement/deploy the POC in a production environment?
  - It's not aimed for production environments.
- How long does it take to deploy the POCed solution?
  - Just a few minutes, since we created using Terraform code.
- What is the plan for supporting and maintaining the solution after production?
  - NA.

## Costs

- Are there any licensing costs involved?
  - No.
- What was the initial setup cost?
  - None.
- What are the expected running costs?
  - NA.
- What should the client plan in terms of maintenance or upkeep costs?
  - There is no cost in terms of maintenance.
- Are there any supporting costs?
  - No.

## Security

- What security measures are included in the solution?
  - N/A.
- How might the solution impact the client's overall IT security posture?
  - N/A.

## Customizability

- How customizable is the solution to meet the unique needs of the client?
  - Very customizable.
- What would be the cost and time implications of customization?
  - The number of hours to implement the customization.