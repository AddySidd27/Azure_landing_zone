# Multi-Region Design

Do not create management groups only to represent Azure regions. Region selection belongs in workload architecture, connectivity, data, deployment, and recovery design unless a regulatory requirement needs a separate policy boundary.

## Platform questions

- Is the hub regional or global?
- Will each region have its own Firewall and DNS endpoints?
- How will on-premises routes reach each region?
- Which logs remain available during a regional failure?
- Where is Terraform state stored and recovered?
- Which platform services need paired or independent regions?
- How will workloads fail over without creating asymmetric routing?

## Workload questions

- Active-active or active-passive?
- Recovery time and recovery point objectives?
- Data replication and consistency?
- Global traffic routing?
- Capacity available in the recovery region?
- Failback process?

Landing zones provide the governed regional foundation. Each workload still needs its own recovery architecture and test evidence.

Microsoft references: [Azure landing zone management groups](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) and [Reliability in the Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/reliability/)

