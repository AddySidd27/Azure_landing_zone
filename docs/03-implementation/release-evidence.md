# Release Evidence

This page records the evidence that exists for this repository today, and what is still missing. It is split into two parts so they are not mixed up: **CI evidence** (automated checks on GitHub) and **deployment evidence** (a real run in Azure).

## CI evidence (published)

These results come from the public GitHub Actions workflow [`terraform-ci.yml`](../../.github/workflows/terraform-ci.yml). Anyone can open the run links and read the logs.

| Item | Value |
|---|---|
| Workflow | Terraform CI |
| Tested commit | `aa0c482` |
| Trigger | Push to `main` |
| Run date | 2026-10-15 |
| Result | Success, both jobs |
| Terraform version in CI | 1.13.3 |
| Run link | [Run 38757954868](https://github.com/AddySidd27/Azure_landing_zone/actions/runs/38757954868) |

Steps that passed in each job:

| Step | `validate (bootstrap)` | `validate (platform)` |
|---|---|---|
| `terraform fmt -check -recursive` | Passed | Passed |
| `terraform init -backend=false` | Passed | Passed |
| `terraform validate` | Passed | Passed |
| `terraform test` (mocked provider) | Not run for this stack | Passed |
| `scripts/check-repository.sh` | Not run for this stack | Passed |

Earlier successful runs of the same workflow: [run 37869634772](https://github.com/AddySidd27/Azure_landing_zone/actions/runs/37869634772) (commit `0fc1e98`, 2026-10-09) and [run 37835938099](https://github.com/AddySidd27/Azure_landing_zone/actions/runs/37835938099) (commit `11102fc`, 2026-10-08).

### What this evidence shows

- The Terraform files are correctly formatted and pass `terraform validate`.
- The two native test files pass against a **mocked** provider. They check planned resource counts, for example that the core lab plans no Azure Firewall and no Azure Bastion.
- The repository check script passes (required files, no committed state or local values, local links).

### What this evidence does not show

- It does **not** prove a successful Azure deployment. CI never signs in to Azure, never runs a real `plan`, and never runs `apply`.
- It does **not** independently verify the expected resource count in Azure. The counts in the tests are expectations checked against a mock.
- It does **not** check policy compliance, effective routes, DNS resolution, alert delivery or costs.

## Deployment evidence (not published yet)

No plan output, apply output, Azure CLI inventory or portal screenshot from a real Azure subscription is in this repository yet. Until it is added, treat the Terraform as validated and unit-tested, but not as proven in a live subscription.

To add it, run the core lab in a sandbox subscription by following the [core lab run sheet](../04-labs/core-lab-run-sheet.md), then record the items below. Hide subscription IDs, tenant IDs and other sensitive values before you publish anything.

| Evidence to collect | Status |
|---|---|
| Tested commit SHA, run date and environment | Not collected |
| Sanitized `terraform plan` summary | Not collected |
| `terraform apply` result and outputs | Not collected |
| Azure CLI resource inventory | Not collected |
| Portal screenshots with sensitive values hidden | Not collected |
| Cleanup (`terraform destroy`) result | Not collected |

Do not replace a missing item with a hand-written `PASS` file. See [Validation Strategy](validation-strategy.md) for the full list of checks.
