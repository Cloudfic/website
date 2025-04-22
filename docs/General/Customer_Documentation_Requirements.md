# Customer Documentation Requirements: Ensuring Clarity and Control (2025)

Effective customer documentation ensures clarity and understanding of the client's business and technical needs. It also helps in maintaining proper access control and managing organizational changes. This document outlines the essential requirements for customer documentation as of March 22, 2025.

## Guidelines

-   Maintain an up-to-date record of each client's business description, contact information, organizational chart, network and application flow diagrams, and technical discovery data.
-   Document all access changes, including Joiner/Mover/Leaver (JML) events, repository and cloud access, and additional access requirements.

## Must Do

-   Document a detailed description of the client's business, including key functions, products, and services. Understand and document the client's business goals and priorities.
    *   **Why**: Provides context for all technical decisions and ensures alignment with business objectives.
-   Maintain an updated table of client contacts, including their name, role, email, and Slack ID.
    *   **Why**: Facilitates communication and ensures quick access to the right people.
-   Create a comprehensive organizational chart of the client's business to understand the hierarchy and structure.
    *   **Why**: Helps navigate the client's organization and identify key decision-makers.
-   Develop detailed network and application flow diagrams. This should include data flow, dependencies between systems and services, and key network components.
    *   **Why**: Provides a clear understanding of the client's technical environment and dependencies.
-   Provide a thorough description of the client's application and its functionalities. This should include the purpose of the application, its key features, and any unique technical requirements.
    *   **Why**: Ensures a deep understanding of the client's applications and their specific needs.
-   Conduct an extensive technical discovery, documenting the development flow, sprint cadence, deployment timings, application configurations, and environment setups. This should include any specific tools, technologies, or methodologies used by the client.
    *   **Why**: Captures all relevant technical details for effective management and support.
-   Record all JML events and adjust access accordingly. Accountability for maintaining this record lies with the Technical Account Manager (TAM).
    *   **Why**: Ensures proper access control and prevents unauthorized access.
    *   Add access to additional cloud tools as needed, such as Terraform Cloud, CI/CD tools, logging/monitoring tools (e.g., Splunk, Datadog), Managed MongoDB, etc.
    *   When removing access, strike it out, don't delete. This provides a historical record of access changes.
-   Provision access to services for both primary and backup engineers. This ensures continuity of service in case the primary engineer is unavailable.
    *   **Why**: Ensures continuous service delivery and prevents single points of failure.
-   Document details of Identity and Access Management (IAM). This should include information on the use of cross-roles, role-based access control, and any other IAM practices implemented.
    *   **Why**: Provides a clear understanding of the client's security posture and access controls.

## Should Do

-   Consider creating a comprehensive customer profile that includes additional information such as the client's business strategy, competitive landscape, key stakeholders, and major projects or initiatives. This can provide a broader context for understanding the client's needs and priorities.
    *   **Pros**: Provides a holistic view of the client's business.
    *   **Cons**: Requires additional research and effort.
-   Consider documenting the client's IT policies and procedures, such as change management, incident management, and security protocols. This can help ensure alignment with the client's operational practices.
    *   **Pros**: Ensures alignment with client's processes, improves collaboration.
    *   **Cons**: Requires access to client's internal documentation.

## Could Do

-   Investigate the use of OpenID Connect (OIDC) providers like Keycloak, Okta, or AWS SSO for cloud access in the future. This can simplify the management of access and authentication.
    *   **Pros**: Streamlines access management, enhances security.
    *   **Cons**: Requires implementation and integration with OIDC providers.

## Won't Do

-   Avoid sharing or storing sensitive customer information, such as passwords or API keys, in an unsecured manner. Always follow best practices for data security and privacy.
    *   **Why**: Protects sensitive data and prevents security breaches.

## Conclusion

Thorough and accurate customer documentation is crucial for understanding the client's business and technical needs, as well as for maintaining proper access control. Regularly update this documentation to reflect any changes in the client's business or technical environment.

## Tools and Technology

-   [Google Docs](https://docs.google.com/): For note-taking, SOW drafting, and collaborative editing.
    *   **Pros**: Collaborative, easily accessible, supports various document types.
    *   **Cons**: Requires a Google account.