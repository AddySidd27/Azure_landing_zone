# Azure Landing Zone Policy Model

Azure landing zones use policy-driven governance. Azure Policy evaluates resources regardless of whether they are created through the portal, Terraform, Bicep, CLI, or an API.

## Conceptual policy layers

| Scope | Purpose | Example policy categories |
|---|---|---|
| Intermediate root | Baseline shared by the organization | Approved regions, diagnostics, Defender configuration, and resource restrictions |
| Platform | Shared-service baseline | Protection and monitoring of central platform services |
| Identity | Identity platform protection | Public-exposure and network restrictions for identity dependencies |
| Management | Operational visibility | Diagnostic routing, monitoring, and operational configuration |
| Connectivity | Shared network protection | DDoS, routing, DNS, gateway, Firewall, and network guardrails |
| Security | Security operations boundary | Security tooling, log routing, and access separation |
| Landing Zones | Workload-independent baseline | TLS, internet management-port restrictions, encryption, monitoring, and backup |
| Corp | Private and hybrid workload controls | Restrict public exposure; integrate private endpoints and central private DNS |
| Online | Internet-facing workload controls | WAF, DDoS, TLS, logging, and public-exposure review |
| Local | Azure Local controls | Connected-operations controls selected for Azure Local requirements |
| Sandbox | Controlled experimentation | Restricted hub access, ownership, budget, expiry, and cleanup |
| Decommissioned | Retirement control | Deny new deployments while data, access, connectivity, and billing are closed |

These are policy categories, not exact assignment names. Use the current Azure Landing Zones Library as the authoritative source for official policy, initiative, archetype, and architecture assets.

## Policy effects

| Effect | Purpose | Operational consideration |
|---|---|---|
| Audit | Report resources that meet a noncompliant condition | Use first to measure impact and find incorrect assumptions |
| Deny | Block a request that violates the policy condition | Test allowed and denied deployments before enforcement |
| Modify | Add or change supported properties or tags | Remediation needs an assignment identity and required role permissions |
| DeployIfNotExists | Deploy a related resource or configuration when it is missing | Remediation needs an assignment identity, role permissions, correct parameters, and time to complete |

## Safe rollout

1. Map the control to a business, security, or regulatory requirement.
2. Select and parameterize a verified policy definition or initiative.
3. Assign it in audit or another non-enforcing mode at a safe scope.
4. Measure impact and identify false assumptions.
5. Remediate existing resources.
6. Record justified exemptions with an owner, approval, compensating control, and expiry.
7. Test a deployment that should pass and one that should fail.
8. Introduce enforcement through change control.
9. Monitor compliance, exemptions, remediation, and deployment failures.

## Repository boundary

This repository implements one controlled policy assignment example and a remediation lab. It does not reproduce the complete Azure Landing Zones Library. Production policy selection, parameters, assignments, identities, exemptions, and rollout depend on the organization's requirements.

Microsoft references: [Governance design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance), [Azure Policy effects](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/effect-basics), [Azure Landing Zones Library](https://azure.github.io/Azure-Landing-Zones-Library/), and [ALZ archetypes](https://azure.github.io/Azure-Landing-Zones-Library/assets/archetypes/).
