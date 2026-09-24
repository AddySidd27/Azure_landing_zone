# Privileged Access, PIM, and Conditional Access

This chapter defines the platform boundary. Microsoft Entra configuration is tenant-specific and is not created from guessed values in the lab.

## Privileged Identity Management

Use PIM where licensing and requirements permit to make privileged roles eligible instead of permanently active. Define approval, activation duration, MFA, justification, notification, and access-review requirements.

Platform roles at management-group scope have broad inherited impact. Limit them to platform responsibilities and protect activation carefully.

## Conditional Access

Conditional Access can require MFA, compliant devices, approved locations, authentication strength, or other conditions. Test policies in report-only mode and exclude protected emergency-access accounts according to the approved design.

## Emergency access

Maintain emergency accounts that do not depend on the same failure path as normal administration. Protect, monitor, test, and document their use. Emergency access is not a daily administrator account.

## Deployment identities

- Prefer workload identity federation for CI/CD.
- Avoid long-lived client secrets.
- Separate plan and apply permissions when practical.
- Scope permissions to the stacks the identity manages.
- Protect role-assignment and policy-assignment permissions.
- Log and review deployment activity.

## Evidence

- Privileged role inventory
- Eligible versus active assignments
- Activation and approval settings
- Conditional Access report-only results
- Emergency-access test record
- Access-review result

Microsoft references: [Identity and access management design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access) and [Secure privileged access](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-planning)

