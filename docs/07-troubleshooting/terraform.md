# Terraform Troubleshooting

## Wrong subscription

Check both Azure CLI context and Terraform variables. Do not continue until they match.

```bash
az account show --output table
terraform providers
```

## Backend authorization failed

Confirm the storage account, container, Microsoft Entra authentication setting, network access, and the deployment identity's blob-data role.

## State lock

Confirm no pipeline or engineer is actively applying. Never break a lock only because a job appears slow.

## Provider or module upgrade changed the plan

Read release notes, refresh initialization, and inspect schema changes. Do not accept a destructive replacement without understanding it.

## Resource exists outside state

Choose deliberately between import, code change, or controlled deletion. Do not rename resources repeatedly to avoid an import decision.

