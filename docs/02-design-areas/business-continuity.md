# Business Continuity and Platform Recovery

A landing zone supports workload recovery, but it also needs its own recovery plan.

## Platform recovery questions

- Can the team recover Terraform state and its version history?
- Is the repository available if the primary delivery platform is unavailable?
- Are deployment identities and federated credentials documented?
- Can shared DNS, Firewall policy, routes, and monitoring be rebuilt?
- Which platform services are regional?
- What happens to workloads when a hub or region fails?
- Who declares and coordinates recovery?

## Recovery priorities

1. Identity and emergency access
2. State and deployment control plane
3. Connectivity and DNS
4. Security visibility and logging
5. Workload dependencies

Do not assume that infrastructure as code alone is a backup. State, configuration, external dependencies, certificates, secrets, and operational access all need recovery treatment.

Microsoft reference: [Management and business continuity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-business-continuity-disaster-recovery)

