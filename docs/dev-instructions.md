<!-- TOC -->
<!-- /TOC -->

# 📘 CF-INSTRUCTIONS — Cloudfic Foundation

## 🔥 Purpose
The Cloudfic Foundation (cf) project provides reusable, modular, and secure GCP data platform templates and automation tools to bootstrap and manage environments for consulting clients such as zp and 4s.

## 🧰 Prerequisites
- **OS**: Windows 11 (WSL Ubuntu) or macOS/Linux
- **Terraform**: v1.5+ (installed via tfenv, Homebrew, or binary)
- **GCloud CLI**: authenticated with `gcloud auth login` and `gcloud config set project <PROJECT_ID>`
- **GitHub CLI**: `gh` with `repo`, `workflow`, and `org` scopes
- **ChatGPT CLI**: `chatgpt` for code generation (optional)
- **Docker**: optional (for local testing of modules)

## 🗂️ Repository Structure
```bash
.
├── cf-agent/                     # Codex agent configuration
├── cf-docs/                      # Documentation templates and guides
│   ├── env-<client>-<env>.md     # Generated environment docs
│   └── INSTRUCTIONS.md           # Documentation source of truth
├── cf-cli/                       # CLI helpers for automation (coming soon)
├── data-platform-terraform/      # Terraform code for GCP data platform
│   └── data-platform-stg/        # Staging environment
│       ├── main.tf
│       ├── versions.tf
│       ├── variables.tf
│       ├── registry.tf
│       ├── m-network.tf
│       ├── m-iam.tf
│       ├── m-gcs.tf
│       ├── m-bigquery.tf
│       ├── m-cloudcomposer.tf
│       ├── m-gke.tf
│       ├── r-billing-alerting.tf
│       └── r-dataflow-alerting.tf
└── setup-dev.sh                  # Local development setup script
```

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone git@github.com:cloudfic/documentations.git cf
cd cf
```

### 2. Bootstrap Development Environment
Run the setup script to install pre-commit hooks, Terraform tools, and Python dependencies:
```bash
./setup-dev.sh
```

### 3. Initialize and Deploy Staging Environment
```bash
cd data-platform-terraform/data-platform-stg
terraform init
terraform validate
terraform plan -out=stg.plan
terraform apply stg.plan
```
- **Configure variables**: adjust `variables.tf` or create a `stg.tfvars` file to override defaults (project ID, region, dataset names).
- **State backend**: configured in `registry.tf`; customize if self-hosted.

## 🧩 Modules Overview (data-platform-stg)

sequenceDiagram
    participant User
    participant Terraform
    participant GCP
    participant PubSub
    participant Email

    User->>Terraform: Apply configuration
    Terraform->>GCP: Create Billing Budget, Pub/Sub Topics, IAM Bindings
    Terraform->>GCP: Create Notification Channels (Email, Pub/Sub)
    Terraform->>GCP: Create Alert Policy for Dataflow Jobs

    GCP->>PubSub: Send alert message on billing threshold or Dataflow failure
    GCP->>Email: Send alert email on Dataflow failure
    
- **Network**: `m-network.tf` sets up VPCs, subnets, and firewall rules.
- **IAM**: `m-iam.tf` defines service accounts and IAM roles.
- **Storage**: `m-gcs.tf` provisions GCS buckets.
- **BigQuery**: `m-bigquery.tf` creates datasets and views.
- **Cloud Composer**: `m-cloudcomposer.tf` for Airflow orchestration.
- **GKE**: `m-gke.tf` spins up Kubernetes clusters.
- **Billing Alerting**: `r-billing-alerting.tf` configures budget alerts.
- **Dataflow Alerting**: `r-dataflow-alerting.tf` sets up logging-based alerts for Dataflow.

## 📖 Documentation Generation
Generate Terraform module docs:
```bash
cd data-platform-terraform/data-platform-stg
terraform-docs markdown table . > ../../cf-docs/env-<client>-stg.md
```
- Preview with `docsify serve cf-docs`

## 🔄 CI/CD & Quality Gates
Workflows under `.github/workflows/`:
1. **Format & Lint**: `terraform fmt -check`, `tfsec`, `tflint`
2. **Security**: `checkov -d .`
3. **Plan & Apply**: `terraform plan` on PRs, `terraform apply` on merge
4. **Cost Insights**: Infracost for PR cost estimates

Pre-commit hooks (`.pre-commit-config.yaml`) run:
- `black`, `ruff`, `isort` (Python)
- `terraform fmt`, `terraform-docs`, `tfsec`, `tflint`, `checkov`

## 🏷️ Naming Conventions
`<initiative>-<env>-<resource-type>-<component>`
- Example: `dp-stg-gcs-data`, `dp-stg-bq-events`

## 🧪 Testing & Validation
- Local: `tfsec .`, `tflint .`, `checkov -d .`
- CI: GitHub Actions validates each step

## 🤖 ChatGPT CLI Bootstrap (Optional)
```bash
chatgpt generate bootstrap environment --project=data-platform-stg --client=zp
```
Scaffolds:
- Terraform code under `data-platform-stg`
- GitHub Actions workflows
- Documentation stub `cf-docs/env-zp-stg.md`

## 📦 Dependencies
- Source of truth: `cloudfic/documentations`
- Terraform modules: `terraform-google-*`
- Python: Poetry with `pyproject.toml`

## ℹ️ Support & Feedback
Questions or issues? Open an issue or contact the Cloudfic team.

## 📑 Table of Contents
- [🔥 Purpose](#%F0%9F%94%A5-purpose)
- [🧰 Prerequisites](#%F0%9F%A7%B0-prerequisites)
- [🗂️ Repository Structure](#%F0%9F%97%82-repository-structure)
- [🚀 Getting Started](#%F0%9F%9A%80-getting-started)
- [🧩 Modules Overview](#%F0%9F%A7%A9-modules-overview)
- [📖 Documentation Generation](#%F0%9F%93%96-documentation-generation)
- [🔄 CI/CD & Quality Gates](#%F0%9F%94%84-cicd-&-quality-gates)
- [🏷️ Naming Conventions](#%F0%9F%8F%B7%EF%B8%8F-naming-conventions)
- [🧪 Testing & Validation](#%F0%9F%A7%AA-testing-&-validation)
- [🤖 ChatGPT CLI Bootstrap](#%F0%9F%A4%96-chatgpt-cli-bootstrap)
- [📦 Dependencies](#%F0%9F%93%A6-dependencies)
- [ℹ️ Support & Feedback](#%F0%9F%93%B1-support-&-feedback)