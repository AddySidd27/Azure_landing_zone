# Deployment Guide

## 1. Confirm context

```bash
az login
az account set --subscription "<subscription-id>"
az account show --query "{tenant:tenantId,subscription:id,name:name}" --output table
```

## 2. Bootstrap state

Follow `bootstrap/README.md`. Record the output values and create a local `backend.hcl` from the selected example.

## 3. Select a profile

Start with `core-lab`. Use `full-platform` only after reviewing service costs and the design decisions.

## 4. Validate

```bash
cd platform
terraform init -backend-config=../config/core-lab/backend.hcl
terraform fmt -check -recursive
terraform validate
terraform plan -var-file=../config/core-lab/core-lab.auto.tfvars -out=core-lab.tfplan
```

## 5. Review the plan

```bash
terraform show core-lab.tfplan
terraform show -json core-lab.tfplan > core-lab.tfplan.json
```

Confirm target subscription, resource count, locations, network ranges, policy scopes, role assignments, public IP addresses, and paid services.

## 6. Apply the saved plan

```bash
terraform apply core-lab.tfplan
```

## 7. Verify

```bash
terraform output
az group list --query "[?tags.platform=='azure-landing-zone'].{name:name,location:location}" --output table
az network vnet list --query "[].{name:name,address:addressSpace.addressPrefixes}" --output table
az monitor log-analytics workspace list --output table
```

Complete the portal validation lab before describing the deployment as successful.

## 8. Cleanup

Create and review a destroy plan. Do not delete the state storage before destroying the resources it tracks.

```bash
terraform plan -destroy -var-file=../config/core-lab/core-lab.auto.tfvars -out=destroy.tfplan
terraform show destroy.tfplan
terraform apply destroy.tfplan
```

