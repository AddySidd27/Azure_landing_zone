# Contributing

## Change standard

Every change must be understandable, testable, and tied to a requirement.

1. Open an issue or record the design reason.
2. Update code, documentation, tests, and diagrams together.
3. Run `terraform fmt -check`, `terraform init -backend=false`, and `terraform validate` for both Terraform roots.
4. Review cost, security, policy, RBAC, routing, DNS, and replacement impact.
5. Link the relevant Microsoft Learn source for architecture guidance.
6. Use a pull request and peer review before merge.

Do not commit credentials, personal tfvars, state files, saved plans, invented production values, or screenshots containing tenant information.

