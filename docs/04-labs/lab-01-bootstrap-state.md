# Lab 01: Bootstrap Remote State

## Goal

Create a protected Azure Storage container for Terraform state and configure the main platform backend.

## Steps

1. Confirm the Azure CLI tenant and subscription.
2. Copy `bootstrap/terraform.tfvars.example` to `bootstrap/terraform.tfvars`.
3. Replace both GUID placeholders.
4. Run `terraform init`, `fmt -check`, `validate`, and `plan`.
5. Review and apply the saved plan.
6. Copy `resource_group_name` and `storage_account_name` from the `backend` output into a local `backend.hcl`. Keep the profile's own `key`.
7. Confirm blob versioning and delete retention in the Azure portal.
8. Confirm your identity has **Storage Blob Data Contributor** on the storage account (Access control (IAM) > Role assignments). Bootstrap creates this assignment; allow up to 10 minutes before running the platform `terraform init`.

## Success evidence

- Terraform output showing the backend values
- Storage container set to private
- Blob versioning enabled
- No storage keys committed
- Storage Blob Data Contributor assignment for the deployment identity
- Main platform `terraform init` succeeds with Microsoft Entra authentication

## Explain the design

The bootstrap stack is separate because Terraform cannot use a remote backend before the backend exists. State is protected because it controls deployed infrastructure and can contain sensitive metadata. Shared keys are disabled, so access depends on Microsoft Entra ID and a blob data role rather than a storage key that could leak.

