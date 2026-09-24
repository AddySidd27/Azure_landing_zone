# Validation Strategy

Validation has several layers. One green command is not complete evidence.

## Static checks

- `terraform fmt -check -recursive`
- `terraform init -backend=false`
- `terraform validate`
- TFLint
- IaC security scanning
- Secret scanning
- Markdown link checks
- Draw.io and SVG XML parsing

## Plan checks

- Correct tenant and subscription
- Expected resource count
- No unexplained replacements
- No unexpected public IP or public network access
- Correct policy and RBAC scopes
- Correct routes and DNS targets
- Expected paid services
- Expected tags and locations

## Deployment checks

- Terraform output
- Azure CLI inventory
- Portal screenshots with sensitive values hidden
- Peering and effective routes
- DNS resolution
- Policy compliance
- Activity Log ingestion
- Alert delivery
- Budget configuration
- Cleanup plan

## Release evidence

Store CI run links, sanitized plan summary, deployment date, environment, validation results, known limitations, and the tested commit SHA. Do not commit a hand-written `PASS` text file as proof.

