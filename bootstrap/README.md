# Remote State Bootstrap

Terraform cannot store its own state in a storage account that does not exist yet. This small bootstrap stack creates the resource group, storage account, and private blob container used by the main platform stack.

## Run once

```bash
cd bootstrap
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with the correct tenant and subscription IDs.
terraform init
terraform fmt -check
terraform validate
terraform plan -out=bootstrap.tfplan
terraform show bootstrap.tfplan
terraform apply bootstrap.tfplan
terraform output backend
```

Copy the output values into the selected `backend.hcl` file.

## Access model

The storage account disables shared keys, so the platform backend authenticates with Microsoft Entra ID (`use_azuread_auth = true`). Owner and Contributor manage the account but do not include blob data access. Bootstrap therefore assigns **Storage Blob Data Contributor** on the storage account to the identity that runs it. The assignment can take up to 10 minutes to take effect; if the platform `terraform init` returns `403 AuthorizationPermissionMismatch`, wait and retry.

Any other identity that runs the platform stack, such as a pipeline identity, needs the same role on this storage account.

Grant the deployment identity the least privilege required to read and write state blobs. Prefer Microsoft Entra authentication instead of storage account keys. Protect the state resource group and review delete permissions because Terraform state can contain sensitive infrastructure metadata.

