## EDW Engineering with Declarative SQL: A Multi-Cloud Approach (2025)

### Description/Summary

This document outlines best practices for building and managing an enterprise data warehouse (EDW) using a declarative SQL-based framework. While the original document focuses on GCP Dataform, this version expands to include considerations for equivalent services and approaches in AWS and Azure, offering a multi-cloud perspective. The goal is to streamline the process of defining, testing, and deploying data pipelines.

### Goals

*   Simplify the development and management of complex data transformations.
*   Improve data quality through built-in assertion frameworks.
*   Increase agility through version control and CI/CD integration.
*   Enhance collaboration among data engineers.
*   Provide guidance applicable to AWS, Azure, and GCP.

### Pre-POC Generic Questions

*   What are the data sources that will feed the EDW?
*   What are the data transformation requirements?
*   What are the data quality requirements?
*   What are the performance requirements for the EDW?
*   What are the security and compliance requirements?
*   What is the budget for the EDW infrastructure?
*   What is the team's expertise with different cloud data services?
*   Which cloud provider(s) are being considered (AWS, Azure, GCP)?

### Scenarios

1.  Building an EDW on AWS using Redshift, Glue, and a declarative SQL framework.
2.  Building an EDW on Azure using Synapse Analytics, Data Factory, and a declarative SQL framework.
3.  Building an EDW on GCP using BigQuery, Dataform, and Dataflow.

### Results

The result should be a well-managed EDW with high data quality, agility, and collaboration.

### Post-POC Generic Questions

*   Was the chosen framework able to simplify the development and management of data transformations?
*   Did the built-in assertion framework improve data quality?
*   Did the version control and CI/CD integration increase agility?
*   Did the framework enhance collaboration among data engineers?
*   What were the key benefits and drawbacks of using this approach?
*   Were there any unexpected challenges during the POC?
*   Is there enough information to implement this solution in a production environment?
*   How long does it take to deploy the solution?
*   What is the plan for supporting and maintaining the solution after production deployment?

### Lessons Learned

A declarative SQL-based framework can significantly simplify the development and management of an EDW. However, careful planning and configuration are crucial to ensure optimal performance, data quality, and security.

### Spin-Offs and Additional Value-Adding Services

Potential spin-offs include:

*   Developing custom data transformation libraries.
*   Offering managed EDW services.
*   Providing consulting services for data warehousing and analytics.

### Costs

*   Are there any licensing costs involved?
    *   Licensing costs may apply for commercial data warehousing and data integration tools.
*   What was the initial setup cost?
    *   The cost of deploying the EDW infrastructure and configuring the data pipelines.
*   What are the expected running costs?
    *   Resource costs for compute, storage, and data processing.
*   What should the client plan for in terms of maintenance or upkeep costs?
    *   Ongoing maintenance of the EDW infrastructure and data pipelines.
*   Are there any supporting costs?
    *   Potential costs for training, consulting, and third-party tools.

### Ability to Self Maintain

The client needs to:

*   Understand data warehousing principles
*   Have expertise in cloud data services (AWS, Azure, GCP)
*   Possess SQL and data transformation skills
*   Implement and maintain data pipelines

### Scalability

*   How does the solution scale?
    *   The EDW should be able to scale to handle increasing data volumes and query demands.
*   What would be the cost implications of scaling the solution, both upward and downward?
    *   Increased costs for additional resources.
    *   Potential cost savings from optimizing resource utilization.

### Training

*   What kind of training will be required for the client's staff?
    *   Training on cloud data services, data warehousing principles, and SQL.
*   What would be the cost and time implications of this training?
    *   Varies depending on the existing skill set of the team.

### Security

*   What security measures are included in the solution?
    *   IAM policies, network security groups, encryption, access controls, and auditing.
*   How might the solution impact the client's overall IT security posture?
    *   Improved security through centralized management, access control, and data encryption.

### Integration

*   How well does the solution integrate with the client's existing systems and infrastructure?
    *   The EDW should be integrated with the client's existing data sources and applications.

### Disaster Recovery and Business Continuity

*   What provisions are included in the solution for disaster recovery and business continuity?
    *   Replication of data and infrastructure across availability zones/regions.

### Customizability

*   How customizable is the solution to meet the unique needs of the client?
    *   The EDW can be customized to fit the client's specific data sources, processing requirements, and data governance policies.
*   What would be the cost and time implications of customization?
    *   Varies depending on the complexity of the customization.

### Data Migration

*   If data migration is required, how would this process be managed, and what costs may be associated with it?
    *   Data migration may be required when migrating data from on-premises systems to the cloud.
*   What are the potential risks involved with data migration, and how can they be mitigated?
    *   Data loss, downtime, and compatibility issues. Implement robust migration procedures and thoroughly test the migration process.

### Support and Maintenance Post-Production

*   What is the recommended approach to support and maintain this solution once it's in production?
    *   Regular monitoring, patching, upgrades, security audits, and performance tuning.
*   What kind of resources (time, talent, tools) will be needed for ongoing support and maintenance?
    *   Skilled data engineers, cloud infrastructure specialists, and security professionals.
*   Are there any best practices or guidelines to follow for supporting and maintaining the solution?
    *   Follow cloud provider best practices, implement robust monitoring, establish clear incident response procedures, and adhere to security guidelines.
*   What are the expected costs associated with support and maintenance?
    *   Salaries for skilled personnel and costs for monitoring tools.

### Guidelines

*   Define Data Sources and Targets: Identify the diverse data sources that will feed the EDW across AWS, Azure, and GCP. Establish the target data warehouse for storing transformed and curated data.
*   Structure the Dataform Project: Create a Git repository to manage the Dataform project, enabling version control, collaboration, and code review.
*   Develop Transformation Logic: Utilize SQLX (or equivalent) to express data transformation logic.
*   Implement Data Quality Checks: Define data quality checks and validation rules using Dataform's assertion framework (or equivalent).
*   Orchestrate and Deploy Pipelines: Use the Dataform CLI (or equivalent) to compile, test, and deploy data pipelines to the data warehouse.
*   Monitor and Maintain the EDW: Leverage the Dataform UI (or equivalent) to monitor pipeline execution, view data lineage, and track data quality metrics.

### Must Do

*   Define Data Sources and Targets: Begin by identifying the diverse data sources that will feed the EDW.
    *   **Why**: Provides a clear understanding of the data landscape.
*   Establish Targets: Determine the target data warehouse for storing transformed and curated data, with BigQuery being a likely choice.
    *   **Why**: Establishes the destination for transformed data.
*   Create a Git Repository: Establish a Git repository to manage the Dataform project, enabling version control, collaboration, and code review.
    *   **Why**: Enables version control and collaboration.

### Should Do

*   SQLX for Transformations: Utilize SQLX to express data transformation logic. SQLX extends standard SQL with features like JavaScript Templating and Ref function.
    *   **Pros**: Simplifies data transformation logic.
    *   **Cons**: Requires learning SQLX syntax.
*   Assertions for Validation: Define data quality checks and validation rules using Dataform's assertion framework. This allows for testing data integrity, monitoring data quality, and alerting on violations.
    *   **Pros**: Ensures data quality and reliability.
    *   **Cons**: Requires effort to define and maintain assertions.

### Could Do

*   Modularize with Functions: Encapsulate complex transformations within SQLX functions for better organization and maintainability.
    *   **Pros**: Improves code organization and reusability.
    *   **Cons**: Adds complexity to the code.

### Won't Do

*   Avoid manual deployment processes.
    *   **Why**: Manual processes are error-prone and inefficient.
*   Ignore data quality issues.
    *   **Why**: Data quality issues can lead to inaccurate insights and poor decision-making.

### Tools and Technology

*   **GCP:**
    *   [Google BigQuery](https://cloud.google.com/bigquery): Data warehouse
    *   [Google Cloud Storage](https://cloud.google.com/storage): Object storage
    *   [Google Dataform](https://cloud.google.com/dataform): Data transformation tool
    *   [Google Cloud Dataflow](https://cloud.google.com/dataflow): Data processing service
*   **AWS:**
    *   [Amazon Redshift](https://aws.amazon.com/redshift/): Data warehouse
    *   [AWS S3](https://aws.amazon.com/s3/): Object storage
    *   [AWS Glue](https://aws.amazon.com/glue/): ETL service
*   **Azure:**
    *   [Azure Synapse Analytics](https://azure.microsoft.com/en-us/services/synapse-analytics/): Data warehouse
    *   [Azure Data Lake Storage](https://azure.microsoft.com/en-us/services/storage/data-lake-storage/): Object storage
    *   [Azure Data Factory](https://azure.microsoft.com/en-us/services/data-factory/): ETL service
