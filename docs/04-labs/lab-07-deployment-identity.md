# Lab 07: Federated Deployment Identity

## Goal

Configure GitHub Actions to authenticate to Azure without a stored client secret.

## Procedure

1. Create the Microsoft Entra application and service principal.
2. Create a federated credential for the test GitHub environment.
3. Assign the least privilege required for the lab subscription.
4. Configure repository variables for client, tenant, and subscription IDs.
5. Run the validation workflow without apply permissions.
6. Protect an apply environment with reviewer approval.
7. Review the Microsoft Entra sign-in log and Azure Activity Log.

## Evidence

- Federated credential subject and audience
- No client secret in repository settings
- Successful workflow authentication
- Role assignment scope
- Protected apply environment

Do not copy example IDs from documentation. Use the IDs created in your tenant.

