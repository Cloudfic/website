# CI/CD Proven Practices

This document outlines proven practices for implementing Continuous Integration and Continuous Delivery (CI/CD) pipelines, based on practical experience in automating tasks, ensuring code quality, and managing Kubernetes manifests effectively. These practices empower teams to focus on innovation and delivery.

## Must Do

- **Implement GitHub Actions for CI/CD:** GitHub Actions is a go-to tool for CI/CD, offering seamless integration with GitHub, an extensive marketplace for reusable actions, and the ability to automate tasks like building containers and managing Kubernetes manifests.
  - **Pros:** Tight integration with GitHub, extensive marketplace, flexible scaling.
  - **Cons:** Can become complex with large workflows, requires familiarity with YAML.
  - **Workflow:**
    ```yaml
    name: CI/CD Pipeline
    on: [push, pull_request]
    jobs:
      build:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v4
          - name: Build and Test
            run: ./build_and_test.sh
          - name: Publish Artifact
            run: ./publish_artifact.sh
      deploy:
        runs-on: ubuntu-latest
        needs: build
        steps:
          - name: Deploy to GCP
            uses: google-github-actions/setup-gcloud@v2
            with:
              version: 'latest'
              service_account_key: ${{ secrets.GCP_SA_KEY }}
              project_id: your-gcp-project-id

          - name: Authenticate to Google Cloud
            run: |
              gcloud auth activate-service-account --key-file=${{ secrets.GCP_SA_KEY }}
              gcloud config set project your-gcp-project-id
              gcloud container clusters get-credentials your-gke-cluster-name --region your-gcp-region

          - name: Deploy to GKE
            run: |
              kubectl apply -f k8s/deployment.yaml
              kubectl apply -f k8s/service.yaml
    ```

- **Secure Your Pipelines:** Add security checks to your CI/CD pipeline using tools like Trivy. It scans for vulnerabilities in both application code and OS packages, keeping your builds secure from day one.
  - **Pros:** Early detection of vulnerabilities, wide language support.
  - **Cons:** May produce false positives, requires regular updates to vulnerability database.
  - **Implementation:** Automate vulnerability scanning with GitHub Actions to ensure every build is secure and reliable. Integrate Google Cloud IAM into your CI/CD pipeline to enforce strict access control across services like BigQuery and Cloud Storage.

- **Automate Data Pipeline Tests:** Ensure that automated tests are part of your CI/CD pipeline before deploying data jobs (e.g., Dataflow pipelines, BigQuery queries, or Composer DAGs). This can include unit tests for Dataflow pipelines or query linting for BigQuery jobs to catch issues before they reach production.
  - **Pros:** Maintains the integrity of data processing workflows, avoids errors that can corrupt datasets or cause failures downstream.
  - **Implementation:** Use pytest for testing Python-based Dataflow and Composer workflows. Lint your SQL queries using SQLFluff to ensure BigQuery jobs are optimized and error-free.

## Should Do

- **Lint Kubernetes Manifests:** Linting is essential to catch errors early. Tools like Kubeval or Kube-linter ensure your Kubernetes manifests are not only valid but follow best practices.
  - **Pros:** Helps maintain consistency and quality across deployments, reducing the chance of deployment errors.
  - **Implementation:** Set up automated linting checks in your GitHub Actions workflow to ensure all manifests are validated before they are merged into the main branch.

- **Validate Kubernetes Manifests:** If your client’s cloud service doesn’t automatically validate Kubernetes manifests, tools like Pluto and kubent are your best friends. These tools help identify deprecated API versions, ensuring that your manifests remain compatible with your Kubernetes version.
  - **Pros:** Catches issues before deployment, saving you from surprises in production.
  - **Implementation:** Incorporate these tools in your CI pipeline to catch any issues before deployment.

- **Monitor and Track Data Pipelines:** Use Cloud Monitoring and Cloud Logging to track the performance and health of your data pipelines. For example, set up monitoring alerts in GitHub Actions for when a Dataflow job fails or when Composer DAGs exceed a certain runtime.
  - **Pros:** Provides visibility into the health and performance of your data pipelines, enabling proactive issue resolution.
  - **Implementation:** Set up monitoring alerts in GitHub Actions for when a Dataflow job fails or when Composer DAGs exceed a certain runtime.

## Won't Do

- **Avoid Insecure or Deprecated CI/CD Tools:** Avoid using CI/CD tools that have known security vulnerabilities, are deprecated, or have a high maintenance overhead.
  - **Why:** Using such tools can compromise the security and stability of your pipelines.

## Example CI/CD Workflow (zp + CD)

```yaml
name: Code Coverage, Linting, Security Check, and CD

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

permissions:
  contents: write
  pull-requests: write
  id-token: write  # Required for workload identity federation

jobs:
  setup:
    name: Set up Python and Poetry
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: '3.12'

    - name: Install Poetry
      uses: snok/install-poetry@v1
      with:
        version: 1.8.4
        virtualenvs-create: true
        virtualenvs-in-project: true

    - name: Install dependencies
      run: |
        poetry install --with dataflow

  testing:
    name: Testing and Code Coverage
    runs-on: ubuntu-latest
    needs: setup
    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: '3.12'

    - name: Install Poetry for testing job
      uses: snok/install-poetry@v1
      with:
        version: 1.8.4
        virtualenvs-create: true
        virtualenvs-in-project: true

    - name: Install dependencies
      run: |
        poetry install --with dataflow

    - name: Run tests and generate coverage report
      run: |
        poetry run pytest -vv \
          --cov=src \
          --cov-report=xml:coverage.xml \
          --cov-report=html:htmlcov \
          --junitxml=pytest.xml

    - name: Remove .gitignore from htmlcov
      run: |
        find htmlcov -name '.gitignore' -delete

    - name: Deploy Coverage Report to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./htmlcov
        destination_dir: htmlcov
        keep_files: true
        force_orphan: false

    - name: Check coverage percentage
      run: |
        COVERAGE=$(poetry run coverage report --fail-under=80 | grep TOTAL | awk '{print $4}' | sed 's/%//')
        if (( $(echo "$COVERAGE < 80" | bc -l) )); then
         echo "Code coverage is below 80% ($COVERAGE%). Failing the job."
          exit 1
        else
          echo "Code coverage is sufficient ($COVERAGE%)."
        fi

    - name: Comment Coverage Report Link on PR
      uses: actions/github-script@v6
      if: ${{ always() && github.event_name == 'pull_request' }}
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        script: |
          github.rest.issues.createComment({
            issue_number: ${{ github.event.pull_request.number }},
            owner: '${{ github.repository_owner }}',
            repo: '${{ github.event.repository.name }}',
            body: '🔗 [View Code Coverage Report](https://SecondNature-com.github.io/data-platform/htmlcov/)'
          })

    linting:
      name: Linting Check
      runs-on: ubuntu-latest
      needs: [setup, testing]
      steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install Poetry for linting job
        uses: snok/install-poetry@v1
        with:
          version: 1.8.4
          virtualenvs-create: true
          virtualenvs-in-project: true

      - name: Install dependencies
        run: |
          poetry install --with dataflow

      - name: Run pre-commit hooks (Ruff)
        run: |
          poetry run pre-commit run --all-files
        continue-on-error: false

      - name: Create Linting Report
        run: |
          mkdir -p linting
          echo "<html><body><h1>Linting Report</h1><pre>" >> linting/index.html
          poetry run pre-commit run --all-files > linting/linting-results.txt || true
          cat linting/linting-results.txt >> linting/index.html
          echo "</pre></body></html>" >> linting/index.html

      - name: Deploy Linting Report to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./linting
          destination_dir: linting
          keep_files: true
          force_orphan: false

      - name: Comment Linting Report Link on PR
        uses: actions/github-script@v6
        if: ${{ always() && github.event_name == 'pull_request' }}
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          script: |
            github.rest.issues.createComment({
              issue_number: ${{ github.event.pull_request.number }},
              owner: '${{ github.repository_owner }}',
              repo: '${{ github.event.repository.name }}',
              body: '🔗 [View Linting Report](https://SecondNature-com.github.io/data-platform/linting/)'
            })

    security:
      name: Security Check
      runs-on: ubuntu-latest
      needs: [setup, testing, linting]
      steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.12'

      - name: Install Poetry for safety check
        uses: snok/install-poetry@v1
        with:
          version: 1.8.4
          virtualenvs-create: true
          virtualenvs-in-project: true

      - name: Install dependencies
        run: |
          poetry install --with dataflow

      - name: Run Safety check for vulnerable dependencies
        run: |
          mkdir -p security
          echo "<html><body><h1>Safety Security Report</h1><pre>" > security/index.html
          poetry run safety check --full-report | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g' >> security/index.html || true
          echo "</pre></body></html>" >> security/index.html
        continue-on-error: true

      - name: Deploy Safety Report to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./security
          destination_dir: security
          keep_files: true
          force_orphan: false

      - name: Comment Security Report Link on PR
        uses: actions/github-script@v6
        if: ${{ always() && github.event_name == 'pull_request' }}
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          script: |
            github.rest.issues.createComment({
              issue_number: ${{ github.event.pull_request.number }},
              owner: '${{ github.repository_owner }}',
              repo: '${{ github.event.repository.name }}',
              body: '🔗 [View Security Report](https://SecondNature-com.github.io/data-platform/security/)'
            })

    deploy:
      name: Deploy to GCP
      needs: [security]
      runs-on: ubuntu-latest
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      environment: production
      steps:
        - name: Checkout code
          uses: actions/checkout@v4

        - name: Set up gcloud CLI
          uses: google-github-actions/setup-gcloud@v2
          with:
            version: 'latest'
            service_account_key: ${{ secrets.GCP_SA_KEY }}
            project_id: your-gcp-project-id

        - name: Authenticate to Google Cloud
          run: |
            gcloud auth activate-service-account --key-file=${{ secrets.GCP_SA_KEY }}
            gcloud config set project your-gcp-project-id
            gcloud container clusters get-credentials your-gke-cluster-name --region your-gcp-region

        - name: Deploy to GKE
          run: |
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
```

## Conclusion

By following these proven practices, you’ll ensure robust CI/CD pipelines, empowering your team to build smarter, faster, and more securely.

## Tools and Technology

- **[GitHub Actions](https://github.com/features/actions):** Preferred CI/CD tool.
  - **Pros:** Seamless integration with GitHub, extensive marketplace, flexible scaling.
  - **Cons:** Can become complex with large workflows, requires familiarity with YAML.
- **[Open Policy Agent (OPA)](https://www.openpolicyagent.org/):** Policy enforcement tool.
  - **Pros:** Centralized policy enforcement, flexible policy language.
  - **Cons:** Steeper learning curve, requires careful policy design.
- **[Pluto](https://github.com/FairwindsOps/pluto):** Tool to detect deprecated Kubernetes API versions.
  - **Pros:** Simple to use, identifies deprecated APIs.
  - **Cons:** Limited scope, focuses only on API deprecation.
- **[kubent](https://github.com/doitintl/kube-no-trouble):** Tool to detect deprecated Kubernetes API versions.
  - **Pros:** Easy to integrate, provides clear reports.
  - **Cons:** Limited scope, focuses only on API deprecation.
- **[Trivy](https://github.com/aquasecurity/trivy):** A security scanner to detect vulnerabilities in application code, OS packages, and CI/CD pipelines.
  - **Pros:** Easy to use, fast scanning, supports multiple vulnerability databases.
  - **Cons:** May produce false positives, requires regular updates to vulnerability database.
- **[pytest](https://docs.pytest.org/en/stable/):** Testing framework for Python.
  - **Pros:** Easy to use, extensive plugin ecosystem.
  - **Cons:** Requires familiarity with Python.
- **[SQLFluff](https://sqlfluff.com/):** Linter for SQL queries.
  - **Pros:** Enforces consistent SQL style, detects errors.
  - **Cons:** Requires configuration, may not support all SQL dialects.
