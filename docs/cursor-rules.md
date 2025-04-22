# 📏 Cursor Rules — Preferences

This file defines the system prompt and generation rules that Cursor will use within this repository.

---

## System Prompt
Embed the full context from the following sources to guide all completions:

```md
<!-- BEGIN system prompt -->

# Development Instructions
<!-- Paste entire content of dev-instructions.md here -->

# Documentation Summary
<!-- Paste content of docs-summary.md here -->

# Staging Environment Modules (data-platform-stg)
Source: `data-platform-terraform/data-platform-stg`
- Use Terraform modules: m-network, m-iam, m-gcs, m-bigquery, m-cloudcomposer, m-gke, r-billing-alerting, r-dataflow-alerting
- Remote state backend: HCP Terraform backend as configured in `registry.tf`

<!-- END system prompt -->
```

---

## Scopes & Overrides
- **Domain**: GCP data platform infrastructure, Terraform-first, GitHub-native workflows
- **Enforce**: Use Terraform modules for all resources; no ad-hoc HCL resources
- **Backend**: Always configure HCP Terraform remote state (per `registry.tf`)
- **Context files**:
  - `dev-instructions.md` — environment bootstrap steps
  - `docs-summary.md` — documentation index

---

## User Profile
- **OS**: Windows 11 (WSL Ubuntu)
- **Shell**: ZSH + Powerlevel10k
- **Tools**: Terraform v1.5+, GCloud CLI, GitHub CLI, ChatGPT CLI
- **Scripts**: `setup-dev.sh`, `expo_repo.sh`

---

## Examples

**1. Generating a new Terraform module**
> "Generate a new Terraform module for Pub/Sub with variables, outputs, and documentation."
- Cursor should scaffold under `modules/pubsub`, include `variables.tf`, `outputs.tf`, `README.md`, and reference HCP backend.

**2. Updating staging environment**
> "Add a new BigQuery dataset to staging env"
- Cursor should modify `data-platform-stg/m-bigquery.tf`, adding a dataset block via module, follow naming conventions, and update docs.

**3. Formatting documentation**
> "Update documentation for network module"
- Cursor should edit `cf/documentations/docs-summary.md` and `cf/documentations/dev-instructions.md` sections following existing markdown style.

*(Adjust rules or add more examples as needed.)* 