# Core-Lab Run Sheet

Use this sheet to run the **core lab** once in a sandbox Azure subscription and collect safe, redacted evidence of what happened.

## How to read this sheet

- **Expected from the code** means the result is worked out by reading the Terraform files. It is a prediction, not something that was observed. When you run the lab, record what you actually see. If it differs, the difference is the finding.
- No result is claimed here. At the time of writing the repository has no published real-deployment evidence.
- A **term** is explained the first time it appears.
  - *Bootstrap*: a small first Terraform stack that creates the storage where the main stack keeps its state.
  - *State*: the file Terraform uses to remember what it created.
  - *Plan*: Terraform's list of what it would create, change, or delete.
  - *Redact*: hide values you must not share.
  - *Resource group*: a folder-like container for Azure resources.
  - *Peering*: a link that lets two virtual networks exchange traffic.
  - *Log Analytics workspace*: a store for log data that you can query.
  - *Activity Log*: the record of management operations in a subscription.
  - *Action Group*: a saved list of who or what gets notified by an alert.
  - *Management group*: a container above subscriptions, used to apply policy and access to many at once.

More terms are in the [glossary](../08-reference/glossary.md).

## 1. Before you start

Work through this list. Do not run any Terraform until every box is ticked.

- [ ] **Subscription.** Use a dedicated sandbox subscription that holds nothing you care about. Not a production or shared team subscription.
- [ ] **Subscription age.** If the subscription is new, Microsoft Learn says Cost Management features, including budgets, can take up to 48 hours before they work ([Learn](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)). Wait if the budget step below fails.
- [ ] **Sign-in.** Terraform's Azure provider can use your `az login` session. You do not need a separate identity for this run.
- [ ] **Permissions.** You have Owner on the subscription, which covers both creating resources and creating role assignments. The bootstrap creates a role assignment, which needs `Microsoft.Authorization/roleAssignments/write` ([Learn](https://learn.microsoft.com/azure/role-based-access-control/role-assignments-portal)). Owner can also create budgets. A smaller set of roles may work but has not been tested here.
- [ ] **No tenant-level permission needed.** The core lab keeps management groups off.
- [ ] **Region.** Use `eastus2` for the first run, because every example file in this repository uses it. Do not change it.
- [ ] **Tools.** Azure CLI, Terraform 1.9 or newer below 2.0 (`platform/versions.tf`), and Git are installed. Check with `az version` and `terraform version`.
- [ ] **Evidence folder outside the repository.** Run `mkdir -p "$HOME/alz-evidence"`. Keep all captures there so they cannot be committed by accident.
- [ ] **Budget alert exists first.** Complete section 3 before section 4.
- [ ] **Time.** You can finish the run, and the destroy in section 8, in one sitting. Do not leave the lab running overnight.

## 2. Confirm context

```bash
az login
az account set --subscription "<subscription-id>"
az account show --query "{tenantId:tenantId,subscriptionId:id,name:name}" --output table
```

Expected from the code: nothing to predict. Stop if the tenant or subscription is not your sandbox. Write down the two IDs. You compare them with your Terraform files in sections 4 and 5.

Terraform targets the IDs written in the tfvars files, **not** your `az login` context. If they differ, Terraform deploys to the subscription named in the file.

**Capture:** `01-context-before.txt`. This output contains IDs, so run it through the redaction helper in section 9 before saving.

## 3. Create a budget alert first

Do this after you have confirmed the context. The lab creates its own budget, but only after it deploys. Create a separate one by hand before anything else, so an alert exists even if something goes wrong.

1. In the Azure portal open **Cost Management**, then **Budgets**, then **Add**. Follow the [Microsoft Learn budget tutorial](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets).
2. Scope: your sandbox subscription. Reset period: monthly.
3. Choose an amount you are comfortable losing. This repository does not suggest one.
4. Add an alert on actual cost and put your own email on it.
5. Name it `sandbox-guard-manual`. Terraform does not manage it, so you delete it yourself in section 8.

If the portal rejects the budget on a new subscription, Learn says Cost Management features can take up to 48 hours to become available ([Learn](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)). Wait and try again before you deploy anything.

A budget only sends alerts. It does not stop spending ([Learn](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)). Learn also says budgets are evaluated about every 24 hours, so an alert is not instant.

**Capture:** screenshot of the budget list (`02-budget-before-deploy.png`).

## 4. Bootstrap the remote state

```bash
git clone https://github.com/AddySidd27/Azure_landing_zone.git
cd Azure_landing_zone/bootstrap
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`: set `subscription_id` and `tenant_id` to exactly the values from `az account show`. Keep `location = "eastus2"`. Choose a `name_prefix` of 3 to 12 lowercase letters or numbers; the example uses `contoso`. Then run:

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=bootstrap.tfplan
terraform show bootstrap.tfplan
terraform apply bootstrap.tfplan
terraform output backend
```

| Command | Expected from the code |
|---|---|
| `terraform init` | Installs the `azurerm` provider at version 5.4.0 and the `random` provider (`~> 3.7`). |
| `terraform fmt -check`, `terraform validate` | No formatting changes listed; validation reports the configuration is valid. |
| `terraform plan` | Check that the `subscription_id` in `terraform.tfvars` equals the one from `az account show`. `Plan: 5 to add, 0 to change, 0 to destroy.` The five are: a random suffix, a resource group, a storage account, a private `tfstate` container, and a role assignment. |
| `terraform apply` | `Apply complete! Resources: 5 added, 0 changed, 0 destroyed.` |
| `terraform output backend` | Four values: `resource_group_name` (`rg-<name_prefix>-tfstate-eastus2`), `storage_account_name` (`st<name_prefix>tf` plus six random characters), `container_name` (`tfstate`), and `key` (`platform.tfstate`). |

The storage account is expected to have shared keys disabled, versioning on, and 14-day delete retention (`bootstrap/main.tf`).

**Capture:** `03-bootstrap-plan-summary.txt` (the `Plan:` line and the resource list), `04-bootstrap-backend-output.txt`, and a portal screenshot of the storage account's data protection settings and the private container (`05-state-storage-portal.png`).

## 5. Deploy the core platform

From the repository root, create the two local files. Both are ignored by Git.

```bash
cd ..
cp config/core-lab/backend.hcl.example config/core-lab/backend.hcl
cp config/core-lab/core-lab.tfvars.example config/core-lab/core-lab.auto.tfvars
```

Edit them:

- `backend.hcl`: copy `resource_group_name` and `storage_account_name` from the bootstrap output. Keep `container_name`, `use_azuread_auth`, and the `key` value `core-lab.platform.tfstate`.
- `core-lab.auto.tfvars`: set `subscription_id` and `tenant_id`. They must equal the values from `az account show`, and equal the ones in `bootstrap/terraform.tfvars`. Use the same `name_prefix` as the bootstrap, or any other you prefer. Add your email to `budget_contact_emails`. Keep `deploy_management_groups`, `deploy_subscription_policy`, `enable_firewall`, `enable_bastion`, `enable_dns_private_resolver`, and `enable_key_vault` set to `false`, and `defender_plans` empty. Keep `enable_activity_log_diagnostics = true`; it is part of the core lab.

Then run:

```bash
cd platform
terraform init -backend-config=../config/core-lab/backend.hcl
terraform fmt -check -recursive
terraform validate
terraform test
terraform plan -var-file=../config/core-lab/core-lab.auto.tfvars -out=core-lab.tfplan
terraform show core-lab.tfplan
```

Read the plan before you apply it. In `terraform show` output, every `/subscriptions/<id>` value must be your sandbox subscription ID (compare it with `az account show`). Also check the region, address ranges, and that no paid service appears (no Firewall, Bastion, DNS Private Resolver, Key Vault, or Defender). Then:

```bash
terraform apply core-lab.tfplan
terraform output
```

| Command | Expected from the code |
|---|---|
| `terraform init` | Uses the `azurerm` backend and Microsoft Entra authentication. If it fails with `403 AuthorizationPermissionMismatch`, wait up to 10 minutes for the role assignment, then retry. See [Terraform troubleshooting](../07-troubleshooting/terraform.md). |
| `terraform test` | Runs the two test files with a mocked provider, so it does not touch Azure. All test runs are expected to pass. |
| `terraform plan` | `Plan: 20 to add, 0 to change, 0 to destroy.` This number is a count of the active resource blocks with the core-lab values. It is 19 if `enable_activity_log_diagnostics` is `false`, because the diagnostic setting is then skipped. If your count differs for another reason, record it. |
| `terraform apply` | `Apply complete! Resources: 20 added, 0 changed, 0 destroyed.` |

The 20 resources are expected to be (the diagnostic setting is the one that drops out when its flag is false):

| Group | Resources |
|---|---|
| Connectivity (15) | Resource group `rg-<name_prefix>-connectivity-lab-eastus2`; hub network `vnet-<name_prefix>-hub-lab-eastus2`; spoke network `vnet-<name_prefix>-workload-lab-eastus2`; five hub subnets (`AzureFirewallSubnet`, `AzureBastionSubnet`, `snet-dns-inbound`, `snet-dns-outbound`, `snet-private-endpoints`); one spoke subnet `snet-workload`; two peerings (`peer-hub-to-workload`, `peer-workload-to-hub`); network security group `nsg-<name_prefix>-workload-lab` and its subnet association; route table `rt-<name_prefix>-workload-lab` and its subnet association. |
| Management (5) | Resource group `rg-<name_prefix>-management-lab-eastus2`; Log Analytics workspace `law-<name_prefix>-lab-eastus2` (30-day retention); Action Group `ag-<name_prefix>-lab`; subscription Activity Log diagnostic setting `send-activity-log-to-platform-law`; subscription budget `budget-<name_prefix>-lab`. |

The five reserved subnets (firewall, Bastion, and DNS) are created even though those services are off. They hold no billable service.

Expected `terraform output`:

| Output | Expected value |
|---|---|
| `resource_groups` | `connectivity` and `management` group names as above; `security` is `null`. |
| `networking` | `hub_vnet_id`, `spoke_vnet_id`, and `workload_subnet_id` as full resource IDs (they contain your subscription ID); `firewall_private_ip` is `null`. |
| `management` | `log_analytics_workspace_id` and `action_group_id` as full resource IDs. |
| `enabled_features` | `management_groups`, `subscription_policy`, `firewall`, `bastion`, `dns_private_resolver`, and `key_vault` are all `false`; `defender_plans` is an empty list. |

**Capture** (use `-no-color` and the redaction helper from section 9):

- `06-terraform-test.txt`: output of `terraform test -no-color`.
- `07-plan-summary.txt`: `terraform show -no-color core-lab.tfplan`, redacted. Keep at least the resource list and the `Plan:` line.
- `08-apply-summary.txt`: the `Apply complete!` line and the resource list.
- `09-terraform-output.txt`: `terraform output -no-color`, redacted.

### If something fails

- **A resource fails during apply.** Read the error, fix the cause, then run `terraform plan` again and `terraform apply` again. Terraform records what it already created, so the next plan is expected to show only the remaining resources (for example 19 of the 20 if one failed). Record each error for section 10.
- **Resource provider not registered.** On a fresh subscription an error such as `MissingSubscriptionRegistration` or `NoRegisteredProviderFound` means a resource provider is not registered. The Azure provider for Terraform may register some providers automatically; this has not been verified here. Learn: [Resolve errors for resource provider registration](https://learn.microsoft.com/azure/azure-resource-manager/troubleshooting/error-register-resource-provider). Register the namespace named in the error with `az provider register --namespace <namespace>`, wait, and re-plan.
- **Budget rejected on a new subscription.** See section 3.
- **`403 AuthorizationPermissionMismatch`.** See the table above.

Never send or publish `core-lab.tfplan`, a `.tfplan.json` file, state files, `backend.hcl`, `terraform.tfvars`, or `*.auto.tfvars`. They contain IDs and email addresses.

## 6. Verify and capture

Still in `platform`. Replace the angle-bracket values with the names printed by `terraform output`.

### 6.1 Resource groups and resources

```bash
az group list --query "[?tags.platform=='azure-landing-zone'].{name:name,location:location}" --output table
az resource list --resource-group <connectivity-resource-group> --output table
az resource list --resource-group <management-resource-group> --output table
```

Expected from the code: two groups, in `eastus2`. Resource names as in the table in section 5. The state storage group is not listed, because it has different tags.

**Capture:** `10-resource-groups.txt`, plus portal screenshots of both resource groups' resource lists (`11-rg-connectivity-portal.png`, `12-rg-management-portal.png`). Show the tags on one resource: expected tags are `environment`, `managed_by`, `platform`, plus `owner` and `cost_center` from your tfvars.

### 6.2 Network, peering, and routes

```bash
az network vnet list --query "[].{name:name,address:addressSpace.addressPrefixes}" --output table
az network vnet peering list --resource-group <connectivity-resource-group> --vnet-name <hub-vnet-name> --output table
az network vnet peering list --resource-group <connectivity-resource-group> --vnet-name <spoke-vnet-name> --output table
az network nsg list --resource-group <connectivity-resource-group> --output table
az network route-table list --resource-group <connectivity-resource-group> --output table
```

Expected from the code: a hub range of `10.10.0.0/16` and a spoke range of `10.20.0.0/16` if you kept the example values; one peering on each network; peering state `Connected` on both once both exist ([Learn](https://learn.microsoft.com/azure/virtual-network/virtual-network-manage-peering)). The route table is expected to have **no custom routes**, because the default route is only added when the firewall is enabled (`platform/networking.tf`).

The core lab has no virtual machine, so there is no network interface and therefore no **effective routes** view to capture. Do not claim a route test. A route table screenshot showing the subnet association and zero routes is the honest evidence.

**Capture:** `13-vnets-and-peering.txt`, portal screenshots of the peering status on both networks (`14-peering-portal.png`), and the route table with its subnet association (`15-route-table-portal.png`).

### 6.3 Logs and diagnostics

```bash
az monitor log-analytics workspace list --output table
az monitor diagnostic-settings subscription show --name send-activity-log-to-platform-law
```

Expected from the code: one workspace named `law-<name_prefix>-lab-eastus2` with 30-day retention; a diagnostic setting that sends eight categories (Administrative, Security, ServiceHealth, Alert, Recommendation, Policy, Autoscale, ResourceHealth) to that workspace.

In the portal, open the workspace, choose **Logs**, and run this query from the Learn Activity Log article ([Learn](https://learn.microsoft.com/azure/azure-monitor/fundamentals/activity-log)):

```kusto
AzureActivity
| summarize count() by CategoryValue
```

The first rows may take time to appear. Wait and run it again. Note the time you applied and the time rows first appeared. Learn does not state a delay for this page, so record what you see.

**Capture:** `16-workspace-and-diagnostics.txt`, and `17-activity-log-query.png`.

### 6.4 Budget

```bash
az consumption budget list --output table
```

`az consumption budget` is marked **Preview** in Microsoft Learn. If it fails, use the portal budget list instead.

Expected from the code: a monthly budget named `budget-<name_prefix>-lab` with the amount from your tfvars and one alert at 80 percent of actual cost. It notifies the Action Group, subscription Owners, and any emails you listed. Your manual `sandbox-guard-manual` budget also appears.

**Capture:** `18-budget-after-deploy.png` (hide emails and IDs).

### 6.5 Policy and management groups in the core lab

In the core lab, `deploy_subscription_policy` and `deploy_management_groups` are both `false`, so Terraform creates **no policy assignment and no management group**. For the core run, capture two honest "nothing created" screenshots:

- Policy, then Assignments, scoped to the subscription: `19-policy-assignments-core.png`. Other assignments may exist if your tenant already has them; note that they are not from this repository.
- Management groups, showing where your subscription sits, unchanged: `20-management-group-position-core.png`.

The optional add-ons in section 7 produce the audit-mode policy and the management group tree.

## 7. Optional add-ons

Do these only after sections 1 to 6 are captured, and only in a sandbox tenant. Each add-on changes your `core-lab.auto.tfvars`, so plan, read, and apply again. Destroy in section 8 still removes them.

### Add-on A: audit-mode policy assignment (subscription scope)

1. Set `deploy_subscription_policy = true` and keep `allowed_locations = ["eastus2", "centralus"]`.
2. Run `terraform plan -var-file=../config/core-lab/core-lab.auto.tfvars -out=policy.tfplan`, then `terraform show policy.tfplan`.
3. Expected from the code: `Plan: 1 to add, 0 to change, 0 to destroy.` The one resource is a subscription policy assignment named `allowed-locations-audit`, display name "Audit resources outside approved locations", using the built-in Allowed locations definition, with `enforce = false`. In the portal this is expected to show as enforcement mode Disabled (`DoNotEnforce`). Learn says that mode evaluates compliance without enforcing the policy effect when resources are created or updated ([Learn](https://learn.microsoft.com/azure/governance/policy/concepts/assignment-structure#enforcement-mode)).
4. Run `terraform apply policy.tfplan`.
5. In the portal open Policy, then Compliance. Learn says a new assignment takes about five minutes to apply and then evaluation starts ([Learn](https://learn.microsoft.com/azure/governance/policy/how-to/get-compliance-data#evaluation-triggers)). Record the compliance result as shown. This sheet does not predict it.

**Capture:** `21-policy-assignment.png` (assignment details showing audit mode / enforcement off and the parameters) and `22-policy-compliance.png`.

### Add-on B: management group tree (tenant scope)

This changes your tenant, not only your subscription. Use a sandbox tenant.

1. Set `deploy_management_groups = true`. Leave `subscription_placements = {}` so no subscription is moved.
2. Plan and read the plan. Expected from the code: 12 management groups to add, a root named `<management_group_prefix>` with the display name "Enterprise Landing Zone", `Platform` with `Identity`, `Management`, `Connectivity`, and `Security`, `Landing Zones` with `Corp`, `Online`, and `Local`, plus `Sandbox` and `Decommissioned`. The root's parent is not set in the code, so it is expected to sit under the tenant root.
3. Check the permission first. Learn says any user in the tenant can create management groups unless hierarchy protection is on, and that the first management group in a directory can take up to 15 minutes to set up ([Learn](https://learn.microsoft.com/azure/governance/management-groups/create-management-group-portal)). If the apply is denied, stop and record the error.
4. Apply, then open Management groups in the portal.

**Capture:** `23-management-group-tree.png`. Hide the tenant name and ID.

## 8. Destroy everything

Do this the same day. Read the destroy plan before you apply it.

```bash
cd "$(git rev-parse --show-toplevel)/platform"
terraform plan -destroy -var-file=../config/core-lab/core-lab.auto.tfvars -out=destroy.tfplan
terraform show destroy.tfplan
terraform apply destroy.tfplan
```

Expected from the code (core lab only): `Plan: 0 to add, 0 to change, 20 to destroy.` then `Destroy complete! Resources: 20 destroyed.` If you ran add-ons, the numbers grow by what those added (1 for Add-on A, 12 for Add-on B).

Then destroy the state storage. Keep `bootstrap/terraform.tfstate`: it exists only on your computer and Terraform needs it for this step.

```bash
cd ../bootstrap
terraform plan -destroy -out=bootstrap-destroy.tfplan
terraform show bootstrap-destroy.tfplan
terraform apply bootstrap-destroy.tfplan
```

Expected from the code: `Plan: 0 to add, 0 to change, 5 to destroy.`

Finally delete your manual `sandbox-guard-manual` budget in the portal.

**Capture:** `30-destroy-plan-summary.txt`, `31-destroy-complete.txt`, `32-bootstrap-destroy-complete.txt`.

### Check that nothing is left billing

```bash
az group list --output table
az resource list --output table
az consumption budget list --output table
az monitor diagnostic-settings subscription show --name send-activity-log-to-platform-law
```

Expected: no resource group named with your `name_prefix` and `connectivity`, `management`, or `tfstate`; no leftover resources from this lab; no `budget-<name_prefix>-lab` budget; the diagnostic setting is not found. Anything left over is a finding. Delete it by hand and note what Terraform missed.

**Do not report or delete `NetworkWatcherRG`.** Learn says that when you create or update a virtual network, Azure automatically enables Network Watcher in that region, and that this automatic enablement has no impact on your resources or associated charge. The instance is named `NetworkWatcher_<region>` (for example `NetworkWatcher_eastus2`) and sits in a resource group named `NetworkWatcherRG` ([Learn](https://learn.microsoft.com/azure/network-watcher/network-watcher-create)). Terraform does not manage them, so they remain after the destroy. List them as "created by Azure, expected", and leave them. Deleting the instance removes Network Watcher data for that region ([Learn](https://learn.microsoft.com/azure/network-watcher/secure-network-watcher)). If `az resource list` shows them, that is not a leftover.

Also check in the portal:

1. The Log Analytics workspaces page, then **Open recycle bin**. A destroyed workspace stays in a soft-deleted state for 14 days and its name stays reserved ([Learn](https://learn.microsoft.com/azure/azure-monitor/logs/delete-workspace)). Learn does not say a soft-deleted workspace is billed. If you want to reuse the same names right away, recover it and then delete it permanently, or use a different `name_prefix` next time.
2. **Cost Management**, then **Cost analysis**, scope = the subscription, view = **Cost by resource**. Data typically arrives 8 to 24 hours after use ([Learn](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)), so check again after one to two days. The **Resources** smart view also lists deleted resources ([Learn](https://learn.microsoft.com/azure/cost-management-billing/costs/cost-analysis-built-in-views)). Charges should stop growing after the destroy time.

**Capture:** `33-nothing-left.txt`, `34-cost-analysis-day-of-run.png` (may be empty on the day), `35-cost-analysis-one-to-two-days-later.png`.

## 9. Redaction rules

Hide or replace all of these in every file and screenshot you share:

| Value | Where it appears |
|---|---|
| Tenant ID | `az account show`, Terraform variables, portal Overview pages, the directory name at the top right of the portal |
| Subscription ID | Every full resource ID, including `terraform output` and `terraform show` |
| Email addresses | Portal top right corner, budget recipients, Action Group, role assignments |
| Object IDs and user names | Role assignments, `az ad` output |
| Storage account name | Optional. It ends in six random characters and is unique to you. |

Share only text you generated with `-no-color`. Run saved text through this helper first. It replaces every GUID and every email address:

```bash
redact() {
  sed -E 's/[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/<GUID>/g; s/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+/<EMAIL>/g'
}

terraform output -no-color | redact > "$HOME/alz-evidence/09-terraform-output.txt"
```

The helper does not catch tenant domain names or screenshots. Read every file once more by eye before you share it. For screenshots, draw a solid box over the values. Blurring can sometimes be reversed.

Also follow the [portal validation](../03-implementation/portal-validation.md) note on hiding sensitive values.

## 10. What to send back

Send the redacted files from `$HOME/alz-evidence`:

1. A short note listing: the date and time of apply and destroy, the region, whether any add-on was run, your Terraform and Azure CLI versions (`terraform version`, `az version`), and the actual `Plan:` and `Apply complete!` lines.
2. Every file and screenshot named in this sheet, using the same file names.
3. **Differences from "expected from the code".** For each one say what you saw instead. These are the most valuable part.
4. Every error message, redacted, with the command that caused it and what you did to fix it.
5. How long each of these took: bootstrap apply, platform apply, platform destroy, bootstrap destroy.
6. Your result from the nothing-left-billing check and the Cost Management view.

Do **not** send: state files, plan files, `*.tfvars`, `backend.hcl`, unredacted terminal output, or unredacted screenshots.

## Quick filename list

| File | Section |
|---|---|
| `01-context-before.txt` | 3 |
| `02-budget-before-deploy.png` | 2 |
| `03-bootstrap-plan-summary.txt`, `04-bootstrap-backend-output.txt`, `05-state-storage-portal.png` | 4 |
| `06-terraform-test.txt`, `07-plan-summary.txt`, `08-apply-summary.txt`, `09-terraform-output.txt` | 5 |
| `10-resource-groups.txt`, `11-rg-connectivity-portal.png`, `12-rg-management-portal.png` | 6.1 |
| `13-vnets-and-peering.txt`, `14-peering-portal.png`, `15-route-table-portal.png` | 6.2 |
| `16-workspace-and-diagnostics.txt`, `17-activity-log-query.png` | 6.3 |
| `18-budget-after-deploy.png` | 6.4 |
| `19-policy-assignments-core.png`, `20-management-group-position-core.png` | 6.5 |
| `21-policy-assignment.png`, `22-policy-compliance.png` | Add-on A |
| `23-management-group-tree.png` | Add-on B |
| `30-destroy-plan-summary.txt`, `31-destroy-complete.txt`, `32-bootstrap-destroy-complete.txt` | 8 |
| `33-nothing-left.txt`, `34-cost-analysis-day-of-run.png`, `35-cost-analysis-one-to-two-days-later.png` | 8 |
