# Coverage Matrix

This matrix shows what the repository explains, deploys, and validates. `Design` means the topic is documented but depends on organization-specific requirements, licensing, external systems, or cost. It is not presented as deployed evidence.

| Topic | Coverage | Implementation or evidence | Main guide |
|---|---|---|---|
| Billing and tenant | Design | Decision checklist | [Billing and tenant](../02-design-areas/billing-and-tenant.md) |
| Requirements and stakeholders | End-to-end process | Discovery, ownership, risks, regions, cost, and recovery inputs | [Greenfield case](../05-use-cases/greenfield.md) |
| Platform operating model | Design + operations | Responsibility model, support, change, and escalation | [Operating model](../01-foundations/operating-model.md) |
| Landing-zone principles | Design | Architecture rationale | [Design principles](../01-foundations/design-principles.md) |
| Five ALZ design principles | Design guidance | Subscription democratization, policy-driven governance, control plane, application model, and Azure-native alignment | [Design principles](../01-foundations/design-principles.md) |
| Platform vs workload subscriptions | Design + lab boundary | Core/full profiles | [Landing-zone foundation](../01-foundations/what-is-an-azure-landing-zone.md) |
| Identity and access | Design | RBAC scope guidance | [Identity and access](../02-design-areas/identity-and-access.md) |
| PIM and Conditional Access | Design | Evidence checklist | [Privileged access](../02-design-areas/privileged-access.md) |
| Deployment identity | Guided lab | GitHub OIDC procedure | [Deployment identity](../03-implementation/deployment-identity.md) |
| Management groups | Terraform + lab | Reference hierarchy | [Resource organization](../02-design-areas/resource-organization.md) |
| Corp, Online, and Local archetypes | Implemented | Terraform management groups, subscription-placement keys, and hierarchy diagram | [Resource organization](../02-design-areas/resource-organization.md) |
| Security management group | Implemented | Terraform management group and hierarchy diagram; Security subscription and Sentinel remain external | [Security operations](../02-design-areas/security-operations.md) |
| Operational and security workspace separation | Design guidance | Management/Security ownership, RBAC, cost, and retention decisions | [Security operations](../02-design-areas/security-operations.md) |
| Subscription design | Design + lab | Placement map | [Subscription design](../02-design-areas/subscription-design.md) |
| Subscription vending | Operational process | Archetype, placement, RBAC, tags, budget, diagnostics, and connectivity handover | [Subscription vending](../05-use-cases/subscription-vending.md) |
| AVM subscription vending module | Design guidance | Official production automation option; not used by this Terraform | [Subscription vending](../05-use-cases/subscription-vending.md) |
| Governance | Terraform + lab | Audit policy assignment | [Governance](../02-design-areas/governance.md) |
| ALZ policy layering | Design guidance | Conceptual hierarchy model and effect guidance | [ALZ policy model](../08-reference/alz-policy-model.md) |
| Remediation and exemptions | Guided lab | Operational exercise | [Policy remediation lab](../04-labs/lab-08-policy-remediation.md) |
| Hub-spoke | Terraform + lab | Hub, spoke, peering | [Networking](../02-design-areas/networking.md) |
| Firewall and egress | Optional Terraform | Firewall policy and spoke UDR | [Full-platform lab](../04-labs/lab-05-full-platform.md) |
| Bastion | Optional Terraform | Dedicated subnet and public IP | [Full-platform lab](../04-labs/lab-05-full-platform.md) |
| Private DNS | Optional Terraform | Resolver, ruleset, zone links | [DNS diagram](../diagrams/svg/07-dns-resolution-flow.svg) |
| Private endpoint DNS at scale | Design guidance | Central zones and DeployIfNotExists pattern; one Key Vault example is implemented | [Networking](../02-design-areas/networking.md) |
| VPN, ExpressRoute, Virtual WAN | Design | Decision comparison | [Connectivity options](../02-design-areas/connectivity-options.md) |
| Key Vault/private endpoint | Optional Terraform | Private access and DNS | [Security](../02-design-areas/security.md) |
| Defender for Cloud | Optional Terraform | Approved plan list | [Security operations](../02-design-areas/security-operations.md) |
| Sentinel/SIEM | Design | Operating-model decisions | [Security operations](../02-design-areas/security-operations.md) |
| Monitoring | Terraform + lab | Workspace, Activity Logs, Action Group | [Management](../02-design-areas/management.md) |
| AMBA for ALZ | Design guidance | Policy-driven platform alert baseline; not deployed | [Management](../02-design-areas/management.md) |
| AMA and Data Collection Rules | Design guidance | VM telemetry pattern; not deployed | [Management](../02-design-areas/management.md) |
| Service Health alerts | Design guidance | Per-subscription notification requirement; not deployed | [Management](../02-design-areas/management.md) |
| Azure Update Manager | Design guidance | Supported machine patching design; not deployed | [Management](../02-design-areas/management.md) |
| Alert validation | Guided lab | Signal-to-response test | [Monitoring lab](../04-labs/lab-09-monitoring-alert.md) |
| Cost management | Terraform + operations | Subscription budget and review | [Naming, tagging, and cost](../02-design-areas/naming-tagging-cost.md) |
| Business continuity | Design + tabletop | Recovery exercise | [Business continuity](../02-design-areas/business-continuity.md) |
| Multi-region | Design | Platform/workload responsibility model | [Multi-region](../02-design-areas/multi-region.md) |
| Remote state | Terraform + lab | Bootstrap and recovery controls | [Bootstrap lab](../04-labs/lab-01-bootstrap-state.md) |
| Platform CI/CD | GitHub Actions | Format, init, validate, repository checks | [Automation and DevOps](../02-design-areas/platform-automation-devops.md) |
| IaC Accelerator and AVM | Design guidance | Production selection, module composition, pipeline bootstrap, and migration guidance | [Accelerator and AVM](../03-implementation/avm-and-accelerator.md) |
| Greenfield | End-to-end case | Requirements through first workload and operations | [Greenfield](../05-use-cases/greenfield.md) |
| Brownfield | End-to-end case | Inventory through migration, enforcement, and retirement | [Brownfield](../05-use-cases/brownfield.md) |
| AVD workload integration | Use case | Platform/workload boundary | [AVD use case](../05-use-cases/avd-workload-integration.md) |
| Decommissioning | Use case | Lifecycle procedure | [Decommissioning](../05-use-cases/decommissioning.md) |
| Day-2 operations | Operations | Daily to quarterly cadence | [Day-2 operations](../06-operations/day-2-operations.md) |
| Validation evidence | Process + CI | Release evidence requirements | [Validation strategy](../03-implementation/validation-strategy.md) |

## Honest implementation boundary

The repository does not claim to deploy an enterprise billing hierarchy, Conditional Access, PIM, ExpressRoute, VPN, Virtual WAN, Sentinel, or an automated subscription-vending product. Those capabilities require tenant-specific decisions, licensing, provider connectivity, external systems, or a wider deployment scope. They are covered as design and operational patterns.
