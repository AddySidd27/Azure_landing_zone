# Terraform Troubleshooting

## Wrong subscription

Check both Azure CLI context and Terraform variables. Do not continue until they match.

```bash
az account show --output table
terraform providers
```

## Backend authorization failed

Confirm the storage account, container, Microsoft Entra authentication setting, network access, and the deployment identity's blob-data role.

`403 AuthorizationPermissionMismatch` during `terraform init` usually means the identity has no blob data role. Owner and Contributor do not grant blob data access. Bootstrap assigns Storage Blob Data Contributor to the identity that ran it; a different identity needs its own assignment. New role assignments can take up to 10 minutes to take effect.

```bash
az role assignment list --assignee "$(az ad signed-in-user show --query id -o tsv)" --scope "<state-storage-account-id>" --output table
```

## Budget creation failed

A subscription budget notification needs at least one contact email or action group. The platform budget always uses the platform Action Group and the Owner role, so check that the Action Group was created and that `budget_contact_emails` contains valid addresses.

## State lock

Confirm no pipeline or engineer is actively applying. Never break a lock only because a job appears slow.

## Provider or module upgrade changed the plan

Read release notes, refresh initialization, and inspect schema changes. Do not accept a destructive replacement without understanding it.

## Resource exists outside state

Choose deliberately between import, code change, or controlled deletion. Do not rename resources repeatedly to avoid an import decision.

