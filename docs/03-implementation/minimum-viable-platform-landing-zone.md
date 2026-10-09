# Minimum Viable Platform Landing Zone

A possible failure mode is spending months or years designing, engineering and refining the landing zone without meaningfully migrating any workloads. The recommendation is to assemble a minimal platform landing zone that is secure, reachable and correctly governed, and adding more pieces only when workloads require them.

This page has three parts:

1. The seven capabilities and the readiness checks, from the official documentation.
2. What this repository's Terraform deploys today for each capability (from the code in `platform/`).
3. The gaps between this repository and the minimum.

The source article is written for teams that move workloads from on-premises to Azure, so "first workload" means the first workload to move.

## The seven capabilities

The minimum viable platform landing zone for a first migration is the foundation needed to land and operate the first workload.

| # | Capability | What this repository does today |
|---|---|---|
| 1 | A management group hierarchy | `management-groups.tf` creates the example hierarchy when `deploy_management_groups` is `true`. The `core-lab` example sets it to `false`. The `full-platform` example sets it to `true`. |
| 2 | Baseline policy | `governance.tf` assigns the built-in Allowed locations policy at subscription scope when `deploy_subscription_policy` is `true`. It is set to audit (`enforce = false`). |
| 3 | A working hub network with hybrid connectivity to your on-premises network | `networking.tf` creates a hub virtual network, a spoke virtual network, peering in both directions, a network security group with no custom rules for the workload subnet, and a route table that gets a default route only when `enable_firewall` is `true` (see row 7). The code has **no** VPN Gateway, ExpressRoute or Virtual WAN resource, so hybrid connectivity is not deployed. |
| 4 | A DNS that reaches on-premises name servers | `dns.tf` creates an Azure DNS Private Resolver with inbound and outbound endpoints and forwarding rules from `dns_forwarding_rules`, when `enable_dns_private_resolver` is `true`. It is `false` in `core-lab` and `true` in `full-platform`. The forwarding ruleset, the rules and the spoke link are created only when `dns_forwarding_rules` is not empty. It is empty in both examples, so neither example deploys a ruleset that reaches on-premises name servers. |
| 5 | Identities that match the workload mix | The code creates **no** Microsoft Entra groups, role assignments or administrator identity baseline. See [identity and access](../02-design-areas/identity-and-access.md) and [deployment identity](deployment-identity.md). |
| 6 | Central logging | `management.tf` creates a Log Analytics workspace, an Action Group, a subscription Activity Log diagnostic setting to that workspace, and a subscription budget. |
| 7 | A firewall or equivalent network security control | `firewall.tf` creates Azure Firewall with a firewall policy and a baseline rule collection group when `enable_firewall` is `true`. When it is enabled, `networking.tf` also adds a default route (`0.0.0.0/0`) from the workload subnet through the firewall, and the baseline rule allows only the Azure management and Microsoft sign-in addresses (`management.azure.com` and `login.microsoftonline.com`) from the spoke address range. It is `false` in `core-lab` and `true` in `full-platform`. |

Three more points about how to build it:

- Build the foundation from repeatable definitions in Bicep, Terraform or another approved deployment method, not manual changes in the Azure portal, so landing zone changes stay reviewable.
- Spoke virtual networks, workload-specific network security groups and per-workload role assignments belong to the workload migration procedures, not to the platform minimum.
- Design the landing zone so workload teams can pick the right service model without bypassing the shared guardrails of identity, network access, policy, logging and cost controls.

## Baseline policy

Apply only the baseline assignments that prevent risk when workloads are migrated and deployed:

- Deny unmanaged public internet exposure.
- Require the diagnostic settings that feed central logging.
- Steer deployments toward the Azure regions where the platform network and operational model are ready.

If a workload has data residency, sovereignty or regulatory requirements, region restriction is a compliance control, so build it into the baseline policy from the start, for example with allowed locations policies.

Set budgets and alerts at the management group or subscription level before migration, and give someone the job of reviewing them.

## Readiness checks

Run these minimum checks before the first workload migration begins. They are the minimum, not a full design review and not proof that every later risk is gone.

| Area | What to check |
|---|---|
| Connectivity | VPN Gateway or ExpressRoute is live, the routing matches the documented target design, and a representative on-premises virtual machine can reach an Azure private IP over the approved path. |
| DNS and routing | On-premises names, Azure private DNS zones and any needed private endpoints resolve correctly from a representative spoke virtual network. The inspection path, the forced-tunneling choice and the internet breakout path are confirmed. |
| Ingress and segmentation | At least one approved ingress pattern is tested end to end, required segmentation controls are in place, and any public-exposure exception has an owner and a review path. |
| Policy and governance | Required Azure Policy assignments are attached, compliance state is reviewed, region restrictions and exceptions are documented, and budgets or cost alerts are active at the intended scope. |
| Administrative access | RBAC through Microsoft Entra ID groups is checked on the relevant scopes, and the privileged access process for platform administrators is documented and tested. |
| Monitoring and operations | The policy that sends diagnostic settings to the central workspace works, at least one expected alert reaches the right destination, and someone owns patching and vulnerability scanning. |
| Capacity and scale | The platform is sized for measured demand and Azure scaling, not for on-premises peak hardware. Gateway SKU, region placement, subscription limits and budget alerts reflect that demand. |
| Resiliency and SLA | Regions, availability zone support, gateway redundancy, backup standards and alerts are chosen from the SLA and recovery needs of the workloads that will land. |
| Subscription handoff | The subscription vending path can create or set up the first workload subscription, and the expected logging, policy and access baseline is present when the workload team receives it. |
| Workload-like dependency test | A representative test proves the first workload's real dependency path: sign-in method, DNS, network reachability, getting a needed secret, and monitoring visibility. |

For a deeper check of management groups, hub networking and security baselines, see the Azure Landing Zone Review assessment.

## Gaps between this repository and the minimum

This repository is a readable learning implementation, not a production platform. Compared with the minimum, the code has these gaps:

- No hybrid connectivity (capability 3). There is no VPN Gateway, ExpressRoute or Virtual WAN resource.
- No identity baseline (capability 5). There are no Microsoft Entra groups or role assignments in the code.
- Baseline policy is one audit-mode Allowed locations assignment (capability 2). The code has no policy that denies public exposure and no policy that sends resource diagnostic settings to the central workspace.
- Central logging covers the subscription Activity Log (capability 6). Validation should confirm resource-level diagnostic settings, not only subscription-level activity logs.
- The `core-lab` example turns the management group hierarchy, the subscription policy, Azure Firewall and the DNS Private Resolver off. Use `full-platform` only after reviewing the hourly cost of Azure Firewall, Bastion and DNS Private Resolver.

For the production path, see [IaC Accelerator and Azure Verified Modules](avm-and-accelerator.md) and the [enterprise extension](enterprise-extension.md).

## Mistakes to check first

- Designing for months without moving a workload.
- Building the foundation by hand in the portal.
- No readiness check before the first workload.
- Budgets and alerts added late.
- Region rules added late.
- Moving a workload before connectivity is stable.
- Overlapping IP address spaces between on-premises and Azure.
- Waiting on ExpressRoute with no plan B. Plan for weeks or months and to run a VPN Gateway in parallel if dates cannot wait.
- Using the Basic VPN Gateway SKU, which rules it out for most production migration workloads.
- Forced tunneling by default. It is generally an antipattern for migrated workloads.
- One virtual network with one subnet and everything inside it.
- No owner for DNS forwarding rules and private DNS zones.
- Public endpoints with no owner, inspection path or review point.

## Microsoft references

- [Azure landing zones for on-premises experts](https://learn.microsoft.com/en-us/azure/migration/migrate-from-on-premises-platform-landing-zone)
- [Deploy Azure landing zones](https://learn.microsoft.com/en-us/azure/architecture/landing-zones/landing-zone-deploy)
- [Azure landing zone design areas and conceptual architecture](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas)
