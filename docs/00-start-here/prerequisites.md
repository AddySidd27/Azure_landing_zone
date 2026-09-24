# Prerequisites

## Knowledge

You should understand basic Azure resources, resource groups, subscriptions, virtual networks, and Terraform syntax. The repository explains landing-zone concepts but does not teach basic command-line usage from zero.

## Tools

- Azure CLI
- Terraform version required by `platform/versions.tf`
- Git
- A code editor
- draw.io desktop or diagrams.net for editing diagrams

## Azure access

For the core lab, you need:

- an Azure subscription where you can create resource groups and networking resources;
- permission to create role assignments only if the RBAC examples are enabled;
- permission to create subscription-level policy assignments only if governance deployment is enabled.

For the enterprise management-group path, you also need permission to create and manage management groups and assign policy at management-group scope. Use a dedicated lab tenant when possible. Do not experiment with tenant-wide controls in a production tenant.

## Confirm the active context

```bash
az login
az account show --output table
az account list --output table
az account set --subscription "<subscription-id>"
az account show --query "{tenantId:tenantId,subscriptionId:id,name:name}" --output table
```

Stop if the tenant or subscription is not the intended target.

## Local environment variables

Terraform can read authentication values from the Azure CLI session. CI should use workload identity federation or another approved non-interactive identity. Do not commit secrets or personal `.tfvars` files.

