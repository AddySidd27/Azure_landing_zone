# Identity and Access Management

Identity is a primary security boundary.

## Baseline design

- Use Microsoft Entra groups instead of assigning many users directly.
- Apply least privilege at the smallest practical scope.
- Use Privileged Identity Management for eligible privileged access where licensing and requirements permit.
- Maintain protected emergency access accounts.
- Use managed identities for Azure workloads where supported.
- Use workload identity federation for CI/CD instead of long-lived client secrets.
- Review privileged and guest access on a schedule.

## Scope example

A network operations group can receive a network role on the connectivity subscription. An application team normally receives access only to its workload subscription or resource groups. Broad management-group permissions are reserved for controlled platform operations.

## Policy is not RBAC

RBAC controls who can perform an action. Azure Policy evaluates whether the resulting resource configuration is allowed or compliant. PIM controls how privileged access is activated. These controls solve different problems.

Microsoft reference: [Identity and access management](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access)

