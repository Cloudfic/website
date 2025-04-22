# Scaling
In this section, we will discuss the best practices for scaling resources to meet demand. Scaling is an essential part of managing cloud resources and can directly impact the performance, availability, and cost-effectiveness of your solutions.

## Guidelines
* Understand the workload: Before implementing any scaling solution, it's essential to understand the workload and its patterns. Analyze metrics related to CPU usage, memory usage, network I/O, and other relevant factors. 
How to Understand it properly:
- This can be reached by testing with the Developers/QA/Architects of the product where we can analyze the workloads properly.
- Creating or using dashboards and solutions as APMs or Grafana Dashboards to monitor the golden signals of each API.
* Autoscaling: Consider using autoscaling capabilities provided by cloud service providers. Autoscaling allows resources to be scaled based on demand, ensuring optimal resource usage.
* Predictive scaling: Use machine learning to analyze historical data and predict future demand. Predictive scaling can help to proactively adjust resources before a demand spike occurs.

## Must Do
* Implement Autoscalling Service in respective Cloud Provider, ASGs allow you to maintain the optimal number of instances to handle the load. ASGs can automatically scale out (add instances) or scale in (remove instances) based on demand.

## Should Do
* Implement scaling policies: Define clear scaling policies that determine when(Reach X percentage, or Number of Requests) and how resources should be scaled.
* Regularly review and adjust scaling settings: Scaling is not a set-and-forget task. Regularly review the performance and adjust the scaling settings as necessary.
* Implement capacity buffers: Maintain a capacity measured to handle sudden increases in demand or to provide time for scaling actions to complete.

## Could Do
* Implement custom metrics: In some cases, the standard metrics may not accurately reflect the workload's demand. In such cases, implement custom metrics for autoscaling as for example Healthchecks in each App returning information about the connection with each critical resource necessary for it works properly.

## Won't Do
* Manual scaling: Manual scaling can lead to over-provisioning or under-provisioning of resources, leading to higher costs or poor performance. It's not recommended unless there's a specific reason not to use autoscaling.

## Conclusion
Effective scaling practices are crucial to manage the performance, availability, and cost of your solutions. By implementing tools like KEDA and ASG, and by following the guidelines outlined above, you can ensure that your resources are scaled effectively to meet demand.

## Tools and Technology
[!!Put more Links!!]
* [Auto Scaling Groups (ASG)](https://aws.amazon.com/autoscaling/): An AWS service that allows you to maintain the optimal number of instances to handle the load
* [AWS Lambda](https://aws.amazon.com/lambda/): A serverless compute service that runs your code in response to events and automatically manages the underlying compute resources for you
* [Google Cloud Functions](https://cloud.google.com/functions): A serverless execution environment for building and connecting cloud services
