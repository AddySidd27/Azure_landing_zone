# Resource Organization

## Recommended hierarchy

Use an intermediate root management group below the tenant root. Under it, separate platform subscriptions from workload subscriptions.

```text
Tenant Root Group
└── Intermediate root
    ├── Platform
    │   ├── Identity
    │   ├── Management
    │   ├── Connectivity
    │   └── Security
    ├── Landing Zones
    │   ├── Corp
    │   ├── Online
    │   └── Local
    ├── Sandbox
    └── Decommissioned
```

Do not mirror the company organization chart. Build the hierarchy around policy, security, connectivity, and operating requirements shared by groups of subscriptions.

## Landing-zone archetypes

An archetype is a collection of Policy and RBAC assets applied to a management group. Subscriptions inherit the resulting control model through their placement. Multiple archetypes can contribute to a management group, and inheritance from parent groups also affects the final result.

| Archetype | Typical workload | Connectivity | Example guardrails |
|---|---|---|---|
| Corp | Internal systems such as payroll or line-of-business applications | Private or hybrid connectivity through shared hubs | Restrict public exposure, use private endpoints, central DNS, and inspected routes |
| Online | Public websites, APIs, and internet-facing services | Direct internet exposure or independent connectivity; a VNet is optional | Permit approved public endpoints with TLS, WAF, DDoS, logging, and exposure review |
| Local | Azure Local workloads | Organization-specific connected operations | Apply Azure Local and hybrid controls selected for the operating model |

`Corp` and `Online` are starting patterns, not departments. Tailor them when requirements differ, but do not create a management group for every application, team, region, or environment. Add a branch only when its inherited Policy or RBAC model must differ.

The Terraform in this repository implements the Platform children and the Corp, Online, and Local children when `deploy_management_groups` is enabled. It does not deploy the complete Microsoft ALZ policy library for those groups.

## Why subscriptions matter

A subscription is a boundary for:

- Azure Policy and RBAC scope;
- cost ownership;
- quotas and limits;
- workload and environment isolation;
- lifecycle and delegation.

Use separate subscriptions for production and non-production when the risk, access, or lifecycle requires it. Do not create separate management groups only for dev, test, and production.

## Common workload groups

- `Corp`: workloads that need corporate or hybrid connectivity.
- `Online`: internet-oriented workloads that do not need the same corporate connectivity path.
- `Local`: Azure Local scenarios when used.
- `Sandbox`: experimentation with a deliberately different policy set.
- `Decommissioned`: subscriptions being retired and restricted.

Microsoft references: [Management groups](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) and [Tailor the Azure landing zone architecture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz).
