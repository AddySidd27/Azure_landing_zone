# Microsoft Learn Review Record

Last reviewed: 2026-09-24

Microsoft Learn is the primary technical reference for this project. The repository explains the guidance in original, simple language and links readers back to the source.

## Core sources

- [Azure landing zone design areas](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas)
- [Azure landing zone design principles](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles)
- [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options)
- [Management groups](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups)
- [Network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity)
- [Management and monitoring](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management)
- [Security](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/security)
- [Governance](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance)
- [Platform automation and DevOps](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops)

## Detailed source map

| Repository topic | Microsoft source used for review |
|---|---|
| Platform and workload subscriptions | [Azure landing zones overview](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/) |
| Design principles | [Azure landing zone design principles](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles) |
| Management groups and subscription placement | [Management groups](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups) |
| Corp, Online, and Local archetypes | [Tailor the Azure landing zone architecture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/tailoring-alz) |
| Identity and access | [Identity and access management design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/identity-access) |
| Network topology | [Network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) |
| Private endpoint DNS at scale | [Private Link and DNS integration at scale](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale) |
| Security operations | [Security design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/security) |
| Security management group | [Security management group and subscription update](https://techcommunity.microsoft.com/blog/azuregovernanceandmanagementblog/a-new-platform-management-group--subscription-for-security-in-azure-landing-zone/4433287) |
| Governance and cost | [Governance design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance) |
| Monitoring and recovery | [Management design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management) |
| Platform baseline alerts | [Monitor Azure platform landing zone components](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor) |
| AMA and DCRs | [Azure Monitor Agent overview](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview) |
| Subscription vending | [Subscription vending](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending) |
| IaC Accelerator and AVM | [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options) |
| ALZ Terraform modules and provider | [Official Terraform documentation](https://azure.github.io/Azure-Landing-Zones/terraform/) |
| ALZ policy and archetype assets | [Azure Landing Zones Library](https://azure.github.io/Azure-Landing-Zones-Library/) |
| GitHub federated identity | [Connect GitHub Actions to Azure with OpenID Connect](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect) |
| Brownfield adoption | [Transition an existing Azure environment](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/transition) |
| Multi-region reliability | [Well-Architected reliability](https://learn.microsoft.com/en-us/azure/well-architected/reliability/) |

## Source handling

Microsoft Learn is used for architecture principles, scope, and recommendations. Terraform resource arguments are checked against the pinned provider documentation. Organization-specific examples are labelled as examples and are not attributed to Microsoft.

## Review rules

1. A design recommendation must link to a current Microsoft Learn source.
2. An organization-specific choice must be labelled as an example or decision point.
3. A code feature must be tested; documentation alone is not proof.
4. The repository must distinguish a personal lab from an enterprise target.
5. Service and provider versions must be checked before each release.
6. Copied marketing language and unsupported claims are not used.

## Confirmed architectural position

- Subscriptions are units of management and workload isolation.
- A reasonably flat management-group hierarchy applies policy to groups of subscriptions with similar requirements.
- Platform and workload subscriptions have different ownership and lifecycle boundaries.
- Policy-driven governance enables delegated workload ownership inside guardrails.
- Infrastructure as code is the preferred implementation path when the organization can operate it.
- The Azure Landing Zones IaC Accelerator and Azure Verified Modules are the Microsoft-aligned starting points for many organizations.
