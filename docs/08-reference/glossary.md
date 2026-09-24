# Azure Landing Zone Glossary

| Term | Meaning in this repository |
|---|---|
| Azure landing zone | The standardized Azure platform foundation and operating approach for governed workload delivery |
| Platform landing zone | Central foundation for tenant hierarchy, shared identity, management, connectivity, security, governance, and automation |
| Workload subscription | Subscription owned by a workload team and placed under the correct inherited controls |
| Management group | Azure scope that organizes subscriptions for inherited Policy and RBAC |
| Archetype | A collection of policy, role, and related assets applied to a management group to create a type of landing zone |
| Corp | Archetype for internal workloads that need private or hybrid corporate connectivity |
| Online | Archetype for internet-facing or independently connected workloads |
| Local | Optional archetype for Azure Local and connected operations scenarios |
| Sandbox | Controlled experimentation scope with different connectivity, cost, and lifecycle controls |
| Decommissioned | Restricted scope for subscriptions moving through retirement |
| Subscription vending | Repeatable request, creation, placement, configuration, and handover of a governed subscription |
| Policy initiative | Group of Azure Policy definitions assigned and managed together |
| Policy exemption | Approved, scoped, owned, and time-limited exception from a policy assignment |
| Remediation | Process that brings existing resources into compliance with supported `Modify` or `DeployIfNotExists` policies |
| Hub and spoke | Network topology with shared connectivity services in a hub and workload networks in spokes |
| Private endpoint | Network interface that gives an Azure service a private IP address in a VNet |
| DNS Private Resolver | Managed Azure DNS forwarding service for Azure and hybrid name-resolution paths |
| AMBA | Azure Monitor Baseline Alerts, a policy-driven baseline for platform monitoring |
| AMA | Azure Monitor Agent, which collects machine telemetry according to Data Collection Rules |
| AVM | Azure Verified Modules for reusable Bicep and Terraform building blocks and patterns |
| ALZ Library | Microsoft-maintained policy, archetype, role, and architecture assets used by official ALZ implementations |

Microsoft references: [What is an Azure landing zone?](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/), [Tailor ALZ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz), and [Azure Landing Zones Library](https://azure.github.io/Azure-Landing-Zones-Library/).
