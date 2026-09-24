# Subscription Design

A subscription is more than a billing container. It is a boundary for policy, RBAC, cost, quotas, workload ownership, and lifecycle.

## Platform subscriptions

A scaled platform commonly separates shared capabilities:

| Subscription | Typical responsibility |
|---|---|
| Identity | Domain controllers or other shared identity infrastructure when required |
| Management | Log Analytics, monitoring, automation, and management services |
| Connectivity | Hub networking, Firewall, gateways, DNS, and shared private connectivity |
| Security | Central security or SIEM tooling when the operating model requires it |

Do not create an empty subscription only because it appears in a reference diagram. Create it when ownership, access, policy, cost, or lifecycle needs a boundary.

## Application subscriptions

Use subscriptions to isolate workloads and environments when required. A production application commonly has a different risk, access, change, and cost model from non-production.

## Placement questions

- Does the workload need corporate or hybrid connectivity?
- Is it internet-oriented and independent from the corporate network?
- Does it have special regulatory or data-residency controls?
- Who owns cost and operations?
- Which teams need administrative access?
- What is the workload lifecycle?

## Anti-patterns

- One subscription for the entire enterprise
- One subscription per Azure resource
- Management groups for every department
- Management groups created only for Azure regions
- Dev, test, and production management groups without a policy reason
- Workload resources inside the connectivity subscription

Microsoft reference: [Management groups and subscription organization](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)

