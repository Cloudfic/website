# Tuning and Optimizing: Balancing Cost and Performance

This document outlines practical guidelines and strategies for tuning and optimizing systems to achieve the best possible performance at the lowest cost. It covers both cost optimization and performance optimization techniques.

## Guidelines

- Define the bottleneck or metrics to be optimized.
- Define the resource to be optimized.
- Understand the infrastructure and how the application works and flows.
- Understand that different requests and workloads will impact the infrastructure differently in terms of behavior and load.
- Incrementally change one thing at a time that is suspected to be the bottleneck and then measure.
- Always validate changes with relevant benchmarks and performance tests.

## Must Do

- **Cost Optimization**
    - Conduct reactionary audits to understand where costs are currently high and how they can be reduced.
    - Consider using [Kubecost](https://www.kubecost.com/) or [opencost](https://github.com/opencost) for cost management.
        - **Pros**: Real-time cost visibility, helps identify cost-saving opportunities.
        - **Cons**: Requires integration and configuration, can be complex to interpret data.
    - Leverage [AWS Cost Explorer](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/) for cost insights.
        - **Pros**: Provides detailed insights into AWS spending, helps visualize trends.
        - **Cons**: Limited customization options, requires manual analysis.
    - Make strategic resource selections for workloads, like choosing between on-demand vs spot instances. This might change the architecture design and solution proposed. For example, ECS Fargate with multiple capacity providers might be cheaper than an EKS setup.
        - **Pros**: Reduces costs, optimizes resource utilization.
        - **Cons**: Requires careful planning and forecasting, spot instances can be interrupted.
    - Use Terraform for cost estimations. Refer to these resources:
        - [Terraform Cost Estimation](https://www.terraform.io/cloud-docs/cost-estimation)
        - [Pre-commit Terraform InfraCost Breakdown](https://github.com/antonbabenko/pre-commit-terraform#infracost_breakdown)
        - **Pros**: Provides cost estimates for Terraform runs, helps identify cost-saving opportunities.
        - **Cons**: Requires integration with Terraform, estimates may not be accurate.
- **Performance Optimization**
    - Implement a good system (APM or Service Mesh) in place to be able to trace requests throughout the stack and time them.
        - **Pros**: Provides visibility into application performance, helps identify bottlenecks.
        - **Cons**: Requires integration and configuration, can be resource-intensive.
    - Use various infrastructure/applications engineering tools such as caching at various levels of infrastructure/application stack, tuning K8s pods, etc. for requests and volume.
        - **Pros**: Improves application performance, reduces latency.
        - **Cons**: Requires careful planning and implementation, can add complexity.

## Should Do

- Determine if specific clusters can be turned off and on easily.
    - EKS Tools: [Cluster-teardown](https://github.com/aws/aws-cli/issues/3743) and/or [another-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler/cloudprovider/aws) may be viable to use for this.
    - Explore strategies for implementing this - P.O.C.
    - Consider the time it will take to spin the environment back up.
        - **Pros**: Reduces costs during non-business hours, optimizes resource utilization.
        - **Cons**: Requires careful planning and automation, can impact application availability.

## Could Do

- Implement preventative audits for cost optimization to avoid overspending in the first place.
    - **Pros**: Proactive cost control, prevents overspending.
    - **Cons**: Requires regular monitoring and analysis, can be time-consuming.

## Won't Do

- We won't take steps that compromise security or functionality for the sake of cost or performance optimization.
    - **Why**: Security and functionality are paramount, and should not be sacrificed for cost or performance gains.

## Conclusion

Optimizing both cost and performance is key for managing efficient and effective systems. By following these guidelines and must-dos, we can ensure we are getting the best possible performance at the lowest cost.

## Tools and Technology

- [Kubecost](https://www.kubecost.com/): A tool to monitor and manage Kubernetes cluster costs
    - **Pros**: Real-time cost visibility, helps identify cost-saving opportunities.
    - **Cons**: Requires integration and configuration, can be complex to interpret data.
- [OpenCost](https://github.com/opencost): An open-source tool for AWS cost monitoring and alerting
    - **Pros**: Open-source, provides insights into AWS costs.
    - **Cons**: Limited features compared to Kubecost, requires manual configuration.
- [AWS Cost Explorer](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/): An interface provided by AWS to visualize, understand, and manage AWS costs and usage over time
    - **Pros**: Provides detailed insights into AWS spending, helps visualize trends.
    - **Cons**: Limited customization options, requires manual analysis.
- [Terraform](https://www.terraform.io/): An open-source Infrastructure as Code (IaC) software tool
    - **Pros**: Infrastructure as Code, supports multiple cloud providers.
    - **Cons**: Can be complex, requires careful planning and execution.
- [Terraform Cost Estimation](https://www.terraform.io/cloud-docs/cost-estimation): A Terraform Cloud feature that provides cost estimates for Terraform runs
    - **Pros**: Provides cost estimates for Terraform runs, helps identify cost-saving opportunities.
    - **Cons**: Requires integration with Terraform Cloud, estimates may not be accurate.
- [Pre-commit Terraform InfraCost Breakdown](https://github.com/antonbabenko/pre-commit-terraform#infracost_breakdown): A pre-commit hook to breakdown the infrastructure cost
    - **Pros**: Provides cost breakdown before committing changes, helps identify cost-saving opportunities.
    - **Cons**: Requires integration with pre-commit, estimates may not be accurate.