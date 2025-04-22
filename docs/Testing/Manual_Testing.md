# Manual Testing: Ensuring Quality and User Experience Across Cloud Applications (2025)

## Description/Summary

While automated testing is crucial for efficiency and repeatability, manual testing remains invaluable. It provides a deeper understanding of the user experience and helps uncover issues that automated tests might miss. This document outlines best practices for manual testing in cloud environments, focusing on strategies applicable across AWS, Azure, and GCP.

## Goals

-   Ensure comprehensive test coverage by complementing automated tests with manual testing.
-   Uncover usability issues and design flaws that may not be apparent in automated tests.
-   Gain a deeper understanding of the user experience and identify areas for improvement.
-   Validate the application's functionality in real-world scenarios.
-   Promote a culture of quality and user-centric development.

## Pre-POC Generic Questions

-   What are the key user workflows and functionalities that need to be tested manually?
-   What are the potential usability issues and design flaws that need to be uncovered?
-   What are the specific requirements for user experience and accessibility?
-   What manual testing tools and techniques are currently in use (if any)?
-   What is the team's experience with manual testing?
-   What is the budget for manual testing activities?
-   How important is user experience and accessibility to the client?
-   Which cloud provider(s) are being considered (AWS, Azure, GCP)?

## Scenarios

1.  **Usability Testing:** Conduct usability testing sessions with real users to identify usability issues and design flaws in the application.
2.  **Accessibility Testing:** Test the application for accessibility, ensuring that it is usable by people with disabilities.
3.  **Exploratory Testing:** Perform exploratory testing to uncover unexpected issues and edge cases that may not be covered by the test plan.
4.  **Security Testing:** Manually test the application for common security vulnerabilities, such as SQL injection and cross-site scripting.

## Configuration Options

Configuration options vary depending on the specific testing goals and the complexity of the application. Key considerations include:

-   **Test Environment Setup:** Setting up a dedicated test environment that closely mirrors the production environment.
-   **Test Data Management:** Managing test data and ensuring that the tests are repeatable and consistent.
-   **Test Case Design:** Creating detailed test cases that cover all key user workflows and functionalities.
-   **Usability Testing Participants:** Recruiting participants who are representative of the target user base.
-   **Accessibility Testing Tools:** Selecting appropriate accessibility testing tools and techniques.

## Results

The results will vary depending on the specific configuration and the complexity of the application. Key metrics to track include:

-   Number of usability issues and design flaws identified
-   Number of accessibility issues identified
-   Number of defects detected through exploratory testing
-   Time spent on manual testing activities
-   User satisfaction

## Post-POC Generic Questions

-   Were the manual testing activities able to effectively uncover usability issues, design flaws, and other defects that were not detected by automated tests?
-   What were the key benefits and drawbacks of using manual testing?
-   Were there any unexpected challenges during the POC?
-   Is there enough information to implement this solution in a production environment?
-   How long does it take to deploy the solution?
-   What is the plan for supporting and maintaining the solution after production deployment?
-   How easy was it to integrate the manual testing activities with the existing development workflow?

## Lessons Learned

Manual testing is a valuable complement to automated testing. It provides a deeper understanding of the user experience and helps uncover issues that automated tests might miss.

## Spin-Offs and Additional Value-Adding Services

Potential spin-offs include:

-   Offering usability testing and accessibility testing services.
-   Developing custom manual testing frameworks and tools.
-   Creating training materials and workshops on manual testing techniques.

## Costs

-   Are there any licensing costs involved?
    -   No licensing costs for most manual testing tools and techniques.
-   What was the initial setup cost?
    -   The cost of setting up the test environment and creating the test cases.
-   What are the expected running costs?
    -   The cost of paying the manual testers for their time.
-   What should the client plan for in terms of maintenance or upkeep costs?
    -   Ongoing maintenance of the test environment and updating the test cases as the application changes.
-   Are there any supporting costs?
    -   Potential costs for recruiting usability testing participants and for specialized accessibility testing tools.

## Ability to Self Maintain

Document the skills and resources needed to maintain the manual testing environment, including:

-   Familiarity with the programming languages and frameworks used in the application
-   Knowledge of manual testing techniques
-   Understanding of the system architecture and user workflows
-   Strong communication and collaboration skills

## Scalability

-   How does the solution scale?
    -   The manual testing effort can be scaled by adding more testers or by focusing on the most critical user workflows.
-   What would be the cost implications of scaling the solution, both upward and downward?
    -   Increased costs for more testers and more extensive testing.
    -   Potential cost savings from reducing the scope of manual testing during periods of low activity.

## Training

-   What kind of training will be required for the client's staff?
    -   Training on manual testing techniques, usability testing, accessibility testing, and security testing.
-   What would be the cost and time implications of this training?
    -   Varies depending on the existing skill set of the team.

## Security

-   What security measures are included in the solution?
    -   Manual testing can help identify potential security vulnerabilities in the application.
-   How might the solution impact the client's overall IT security posture?
    -   Improved security through early detection of potential vulnerabilities and increased code quality.

## Integration

-   How well does the solution integrate with the client's existing systems and infrastructure?
    -   Integration with issue tracking systems (e.g., Jira) and communication tools (e.g., Slack).

## Disaster Recovery and Business Continuity

-   What provisions are included in the solution for disaster recovery and business continuity?
    -   The test cases and test environment configurations can be stored in version control and easily restored in case of a disaster.

## Customizability

-   How customizable is the solution to meet the unique needs of the client?
    -   Manual testing can be customized to fit specific testing requirements and user workflows.
-   What would be the cost and time implications of customization?
    -   Varies depending on the complexity of the customization.

## Data Migration

-   If data migration is required, how would this process be managed, and what costs may be associated with it?
    -   Data migration may be required when setting up the test environment or when testing data-intensive workflows.
-   What are the potential risks involved with data migration, and how can they be mitigated?
    -   Data loss, downtime, and compatibility issues. Implement robust backup and recovery procedures and thoroughly test the migration process.

## Support and Maintenance Post-Production

-   What is the recommended approach to support and maintain this solution once it's in production?
    -   Regularly update the test cases, review the test environment configuration, and address any issues that arise.
-   What kind of resources (time, talent, tools) will be needed for ongoing support and maintenance?
    -   Skilled manual testers, usability experts, and accessibility specialists.
-   Are there any best practices or guidelines to follow for supporting and maintaining the solution?
    -   Follow the documentation for the chosen testing tools and techniques, adhere to coding best practices, and implement robust communication and collaboration processes.
-   What are the expected costs associated with support and maintenance?
    -   Salaries for skilled personnel, costs for specialized testing tools, and potential costs for user recruitment.

## Guidelines

*   Detailed Scenarios: Create detailed scenarios and steps for manual testing to ensure comprehensive coverage.
*   Comprehensive Coverage: This process helps uncover issues that automated tests might miss and provides a deeper understanding of the user experience.
*   Real User Conditions: Simulate real user scenarios, testing the system from start to finish.

## Must Do

*   Identify key user workflows and functionalities.
    *   **Why**: Provides a clear focus for the manual testing effort.
*   Create detailed test cases that cover all key user workflows and functionalities.
    *   **Why**: Ensures that all aspects of the application are tested.
*   Execute the test cases in a dedicated test environment that closely mirrors the production environment.
    *   **Why**: Ensures that the tests are run in a realistic environment.

## Should Do

*   Involve real users in the testing process.
    *   **Pros**: Provides valuable feedback on the user experience.
    *   **Cons**: Requires recruiting and managing the users.
*   Use a test management tool to track the progress of the manual testing activities.
    *   **Pros**: Provides a centralized view of the testing effort.
    *   **Cons**: Requires setting up and maintaining the test management tool.

## Could Do

*   Use a screen recording tool to capture the manual testing sessions.
    *   **Pros**: Provides a visual record of the testing activities.
    *   **Cons**: Requires additional storage space for the recordings.

## Won't Do

*   Skip manual testing.
    *   **Why**: Manual testing is crucial for uncovering usability issues and design flaws that automated tests might miss.
*   Rely solely on automated tests.
    *   **Why**: Automated tests cannot fully replicate the human experience.

## Tools and Technology

-   **TestRail:** A test management tool.
    -   **Cloud Provider**: Multi-Cloud
-   **Zephyr:** A test management tool that integrates with Jira.
    -   **Cloud Provider**: Multi-Cloud
-   **Screen recording tool:** A tool for capturing screen recordings of the manual testing sessions.
    -   **Cloud Provider**: Multi-Cloud
-   **Accessibility testing tools:** Tools for testing the accessibility of the application.
    -   **Cloud Provider**: Multi-Cloud