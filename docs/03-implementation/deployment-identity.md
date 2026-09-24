# Deployment Identity and GitHub OIDC

Use a dedicated workload identity for automated deployment. GitHub OpenID Connect can authenticate without storing a long-lived Azure client secret.

## Design steps

1. Create or select a Microsoft Entra application and service principal.
2. Add a federated credential restricted to the approved repository, branch, environment, or pull-request subject.
3. Assign the minimum Azure roles required by the stack.
4. Store tenant, subscription, and client IDs as repository or environment variables; they are identifiers, not passwords.
5. Protect the GitHub environment used for apply.
6. Require reviewers for production apply.
7. Record sign-in and Azure Activity Log evidence.

## Permission separation

Planning normally needs read access plus the permissions Terraform requires to refresh data. Applying needs create/update/delete rights. Management-group, policy, and role-assignment operations require broader permissions and should not be mixed into every workload pipeline.

## Do not do this

- Commit a client secret.
- Give every pipeline Owner at tenant or management-group scope.
- Use one unrestricted identity for platform and all workloads.
- Allow pull requests from untrusted code to use production credentials.
- Treat a successful login as proof that the assigned permissions are appropriate.

Microsoft reference: [Use OpenID Connect with GitHub Actions and Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect)

