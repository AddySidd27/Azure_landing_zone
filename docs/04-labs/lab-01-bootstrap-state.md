# Lab 01: Bootstrap Remote State

## Goal

Create a protected Azure Storage container for Terraform state and configure the main platform backend.

## Steps

1. Confirm the Azure CLI tenant and subscription.
2. Copy `bootstrap/terraform.tfvars.example` to `bootstrap/terraform.tfvars`.
3. Replace both GUID placeholders.
4. Run `terraform init`, `fmt -check`, `validate`, and `plan`.
5. Review and apply the saved plan.
6. Copy the `backend` output into a local `backend.hcl`.
7. Confirm blob versioning and delete retention in the Azure portal.

## Success evidence

- Terraform output showing the backend values
- Storage container set to private
- Blob versioning enabled
- No storage keys committed
- Main platform `terraform init` succeeds with Microsoft Entra authentication

## Explain the design

The bootstrap stack is separate because Terraform cannot use a remote backend before the backend exists. State is protected because it controls deployed infrastructure and can contain sensitive metadata.

