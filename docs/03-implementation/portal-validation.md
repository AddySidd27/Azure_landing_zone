# Portal Validation Checklist

## Resource organization

- Management-group parent-child relationships match the approved diagram.
- Every subscription has an owner and correct placement.
- No workload subscription remains under the tenant root accidentally.

## Networking

- Address spaces do not overlap.
- Both peering directions are connected.
- Effective routes match the intended traffic path.
- NSGs and route tables are associated with the correct subnets.
- Firewall, Bastion, and DNS Resolver exist only when enabled.
- Private endpoint DNS resolves to the expected private IP.

## Governance and access

- Policy assignment scope and parameters are correct.
- Audit results appear before enforcement decisions.
- RBAC assignments use groups or workload identities where appropriate.
- Privileged access is eligible/time-bound where the design requires PIM.

## Management and cost

- Subscription Activity Log categories reach Log Analytics.
- Workspace retention matches the selected profile.
- Action Group contacts are real and tested before production use.
- Budget amount and contacts are correct.
- Resource tags identify ownership and environment.

Capture screenshots or command output only after hiding tenant IDs, subscription IDs, email addresses, and other sensitive values.

