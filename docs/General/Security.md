## Security Best Practices Across Cloud Environments (2025)

### Description/Summary

This document outlines essential security guidelines and best practices applicable across AWS, Azure, and GCP environments. It focuses on minimizing the impact of security incidents, enforcing least privilege, and protecting sensitive data.

### Goals

*   Establish a strong security foundation across cloud environments.
*   Minimize the blast radius of potential security incidents.
*   Enforce the principle of least privilege.
*   Protect sensitive data with strong encryption.
*   Balance security with convenience for clients.

### Pre-POC Generic Questions

*   What are the client's specific security and compliance requirements?
*   What data sensitivity levels exist within the client's environment?
*   What are the potential threat vectors and attack scenarios?
*   What existing security controls are in place?
*   What is the budget for security tools and services?
*   What is the team's expertise with cloud security best practices?
*   Which cloud provider(s) are being considered (AWS, Azure, GCP)?

### Scenarios

1.  Managing credentials and access control across AWS, Azure, and GCP.
2.  Securing sensitive data at rest and in transit across cloud environments.
3.  Implementing network security controls in a multi-cloud environment.
4.  Responding to a security incident in a cloud environment.

### Results

The result should be a secure and well-protected cloud environment that meets the client's specific security and compliance requirements.

### Post-POC Generic Questions

*   Are the implemented security controls effective in mitigating potential threats?
*   Are the security controls easy to manage and maintain?
*   Are there any gaps or areas for improvement in the security posture?
*   Are the security controls aligned with the client's business objectives?

### Lessons Learned

Document any key lessons learned during the implementation of security best practices, including unexpected challenges, best practices, and recommendations for future security initiatives.

### Spin-Offs and Additional Value-Adding Services

Identify any potential spin-off projects or additional value-adding services that could be developed based on the security best practices, such as automated security audit tools or incident response playbooks.

### Costs

*   Are there any licensing costs involved?
    *   Licensing costs may apply for commercial security tools and services.
*   What was the initial setup cost?
    *   The cost of implementing the security controls and configuring the security infrastructure.
*   What are the expected running costs?
    *   Resource costs for security tools, monitoring, and incident response.
*   What should the client plan for in terms of maintenance or upkeep costs?
    *   Ongoing maintenance of security controls, regular security audits, and incident response training.
*   Are there any supporting costs?
    *   Potential costs for security consulting, training, and third-party security services.

### Ability to Self Maintain

Document the skills and resources needed to maintain the security posture, including:

*   Cloud security expertise (AWS, Azure, GCP)
*   Security monitoring and incident response skills
*   Knowledge of security best practices and compliance requirements

### Scalability

*   How does the security solution scale?
    *   The security solution should be able to scale to meet the growing needs of the client's environment.
*   What would be the cost implications of scaling the solution, both upward and downward?
    *   Increased costs for additional security tools and services.
    *   Potential cost savings from optimizing security controls and reducing the attack surface.

### Training

*   What kind of training will be required for the client's staff?
    *   Training on cloud security best practices, security tools, and incident response procedures.
*   What would be the cost and time implications of this training?
    *   Varies depending on the existing skill set of the team.

### Security

*   What security measures are included in the solution?
    *   Access controls, encryption, monitoring, and incident response procedures.
*   How might the solution impact the client's overall IT security posture?
    *   Improved security through the implementation of security best practices and the reduction of the attack surface.

### Integration

*   How well does the solution integrate with the client's existing systems and infrastructure?
    *   The security solution should be integrated with the client's existing security tools and processes.

### Disaster Recovery and Business Continuity

*   What provisions are included in the solution for disaster recovery and business continuity?
    *   The security solution should include measures to protect against data loss and ensure business continuity in the event of a disaster.

### Customizability

*   How customizable is the solution to meet the unique needs of the client?
    *   The security solution should be customizable to fit the client's specific environment and requirements.
*   What would be the cost and time implications of customization?
    *   Varies depending on the complexity of the customization.

### Data Migration

*   If data migration is required, how would this process be managed, and what costs may be associated with it?
    *   Data migration may be required when implementing new security controls.
*   What are the potential risks involved with data migration, and how can they be mitigated?
    *   Data loss, downtime, and security breaches. Implement robust migration procedures and thoroughly test the migration process.

### Support and Maintenance Post-Production

*   What is the recommended approach to support and maintain this solution once it's in production?
    *   Regular security audits, policy reviews, and updates.
*   What kind of resources (time, talent, tools) will be needed for ongoing support and maintenance?
    *   Skilled security engineers and security tools.
*   Are there any best practices or guidelines to follow for supporting and maintaining the solution?
    *   Follow industry best practices for security and compliance.
*   What are the expected costs associated with support and maintenance?
    *   Salaries for skilled personnel and costs for security tools.

### Guidelines

*   **Reduce blast radius**: Minimize the impact of potential security incidents by limiting the scope of resources and permissions.
*   **Follow the principle of least privilege**: Grant only the minimum permissions necessary for a task across AWS, Azure, and GCP.
*   **Separate environments**: Maintain clear and distinct separation between development, staging, and production environments across AWS, Azure, and GCP.
*   **Use strong encryption for data in motion or at rest**: Always protect sensitive data with robust encryption protocols across AWS, Azure, and GCP.
*   **Establish a balance between security and convenience with the client**: Always point out any dangerous practices that may be in play, and recommend better practices, but the final decision lies with the client once they are aware of the risks and implications across AWS, Azure, and GCP.

### Must Do

*   **Credentials Management**
    *   Everyone should have individual access to services and avoid using shared credentials across AWS, Azure, and GCP.
    *   In AWS, use cross-organization IAM roles.
    *   Rotate keys if a team member leaves across AWS, Azure, and GCP.
*   **Secure Secret Storage**
    *   Do not store passwords locally or within our organization in Bitwarden. Use the client's password vault or infrastructure across AWS, Azure, and GCP.
    *   For AWS, use [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) with [Velero](https://velero.io/) for backup.
    *   For Azure, use [Azure Key Vault](https://azure.microsoft.com/en-us/services/key-vault/).
    *   For GCP, use [Secret Manager](https://cloud.google.com/secret-manager).
    *   For IBM Cloud, use [Secrets Manager](https://www.ibm.com/cloud/secrets-manager).
    *   For Cloud-agnostic environments, use [Hashicorp Vault](https://www.vaultproject.io/) with a Monitored Cronjob for backup to S3.
    *   For Kubernetes environments, use [External Secrets](https://external-secrets.io/v0.8.3/) to integrate with your external secret management system and securely expose secrets to service in a standardized way;
*   **Cloud Account Management/Subscriptions**
    *   Separate accounts/subscriptions for production and staging environments across AWS, Azure, and GCP. Ensure no cross-account access is possible between the two and that production is not accessible from Dev/Test/Stage.
    *   Use one master/jump account with each child account having access to only provision/view each different environment (production/staging) across AWS, Azure, and GCP.
    *   Refer to [terraform-aws-secure-baseline](https://github.com/nozaq/terraform-aws-secure-baseline) for further enhancements in AWS.
*   **Encryption at rest**
    *   Encryption at rest must be enabled unless explicitly deemed unnecessary based on a thorough risk assessment and compliance requirements across AWS, Azure, and GCP.
    *   For Kubernetes:
        *   Encryption at rest (ETCD Encryption) means that the ETCD data will be encrypted.
        *   Encryption at rest is required even if a Secure Secret Storage is being used.
        *   EKS secret encryption is an optional feature, which uses AWS KMS to encrypt data. See [this](https://docs.aws.amazon.com/eks/latest/userguide/enable-kms.html) user guide for more information.
        *   Use the appropriate cloud provider documentation to leverage encryption at rest.
*   **Enable Logging of the Control Plane for Managed Kubernetes Services**
    *   Control plane logging must be enabled for visibility into it to ensure that the cluster is running as expected, be able to detect anomalous configuration activity and assist with troubleshooting across AWS, Azure, and GCP.
        *   Logging is also required for compliance with various regulations and standards, such as HIPAA, PCI DSS, and SOC 2.

### Should Do

*   **Penetration Testing**
    *   Implement a layered approach. We are not a pen-testing organization, but we can follow basic security guidelines/modules/policies we put in place while building across AWS, Azure, and GCP.
    *   Use free or low-cost tools for basic insight (with client understanding of limitations/liability), such as [awesome-pentest](https://github.com/enaqx/awesome-pentest) and [Kali Linux](https://www.kali.org/).
*   **Security Monitoring/Testing/Assessment**
    *   Use cloud-based services like [AWS Identity and Access Management Access Analyzer](https://aws.amazon.com/iam/features/access-analyzer/).
*   Infrastructure password changes for clients, if dictated by their policy across AWS, Azure, and GCP.
*   Implement scanning, patching, and zero-trust security practices across AWS, Azure, and GCP.
*   Use [AWS security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) for cloud security in AWS. Utilize Azure Network Security Groups and GCP Firewall rules for similar network security controls in Azure and GCP, respectively.
*   **Container Runtime Security**
    *   Consider a runtime security solution that offers real-time threat detection and prevention and enhanced visibility into container activity across AWS, Azure, and GCP.
        *   Falco's driver achieves this as it monitors for suspicious behavior inside a container by capturing syscalls the container makes to the kernel.
    *   Decide on a corresponding action for alerts generated, e.g.
        *   Blocking network traffic,
        *   Terminating containers, or
        *   Sending notifications.

### Could Do

*   Consider paid offerings for more extensive penetration testing across AWS, Azure, and GCP.
*   Coordinate password changes for clients across AWS, Azure, and GCP.
*   Implement Identity and Access Management using OIDC for cross-cloud resource access across AWS, Azure, and GCP.
*   Use a Web Application Firewall (WAF) to protect your applications from common web exploits across AWS, Azure, and GCP.

### Won't Do

*   We won't conduct extensive penetration tests as it is not within our organizational capability across AWS, Azure, and GCP.
    *   **Why**: Requires specialized expertise and resources.

### Conclusion

Through these guidelines and best practices, we aim to ensure a high level of security in all our operations, balancing the needs of security and convenience for our clients across AWS, Azure, and GCP.

### Tools and Technology

*   **AWS IAM** ([https://aws.amazon.com/iam/](https://aws.amazon.com/iam/)): AWS's service for secure cloud resource management
    *   **Cloud Provider**: AWS
*   **AWS Secrets Manager** ([https://aws.amazon.com/secrets-manager/](https://aws.amazon.com/secrets-manager/)): Service for securely storing and managing sensitive information in AWS
    *   **Cloud Provider**: AWS
*   **Velero** ([https://velero.io/](https://velero.io/)): Open-source tool for managing backups and restores of Kubernetes clusters
    *   **Cloud Provider**: Multi-Cloud
*   **Azure Key Vault** ([https://azure.microsoft.com/en-us/services/key-vault/](https://azure.microsoft.com/en-us/services/key-vault/)): Azure's service for securely storing and managing secrets
    *   **Cloud Provider**: Azure
*   **GCP Secret Manager** ([https://cloud.google.com/secret-manager](https://cloud.google.com/secret-manager)): GCP's service for securely storing and managing secrets
    *   **Cloud Provider**: GCP
*   **IBM Cloud Secrets Manager** ([https://www.ibm.com/cloud/secrets-manager](https://www.ibm.com/cloud/secrets-manager)): IBM Cloud's service for securely storing and managing secrets
    *   **Cloud Provider**: IBM Cloud
*   **Hashicorp Vault** ([https://www.vaultproject.io/](https://www.vaultproject.io/)): Open-source tool for secrets management
    *   **Cloud Provider**: Multi-Cloud
*   **terraform-aws-secure-baseline** ([https://github.com/nozaq/terraform-aws-secure-baseline](https://github.com/nozaq/terraform-aws-secure-baseline)): A terraform module to set up your AWS account with the secure baseline configuration based on CIS Amazon Web Services Foundations
    *   **Cloud Provider**: AWS
*   **awesome-pentest** ([https://github.com/enaqx/awesome-pentest](https://github.com/enaqx/awesome-pentest)): A collection of awesome penetration testing resources, tools, and other shiny things
    *   **Cloud Provider**: Multi-Cloud
*   **Kali Linux** ([https://www.kali.org/](https://www.kali.org/)): Linux distribution designed for digital forensics and penetration testing
    *   **Cloud Provider**: Multi-Cloud
*   **AWS IAM Access Analyzer** ([https://aws.amazon.com/iam/features/access-analyzer/](https://aws.amazon.com/iam/features/access-analyzer/)): AWS service that helps you identify the resources in your organization and accounts, such as Amazon S3 buckets or IAM roles, that are shared with an external entity
    *   **Cloud Provider**: AWS
*   **AWS Security Groups** ([https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)): Provides security at the protocol and port access level
    *   **Cloud Provider**: AWS
*   **Azure Network Security Groups**: Provides security at the protocol and port access level
    *   **Cloud Provider**: Azure
*   **GCP Firewall Rules**: Provides security at the protocol and port access level
    *   **Cloud Provider**: GCP
*   **External Secrets Operator** ([https://external-secrets.io/v0.8.3/](https://external-secrets.io/v0.8.3/)): is a Kubernetes operator that integrates external secret management systems like AWS Secrets Manager, HashiCorp Vault, Google Secrets Manager, Azure Key Vault, IBM Cloud Secrets Manager, and many more.
    *   **Cloud Provider**: Multi-Cloud
