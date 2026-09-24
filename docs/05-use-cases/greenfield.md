# End-to-End Use Case 1: Build Azure from the Beginning

## Situation

Northwind Traders has 600 employees and no governed Azure platform. The organization wants to move internal services to Azure, connect Azure to its offices, control cost, and give future workload teams a standard subscription.

The first workload is not the starting point. The organization first builds the shared platform foundation that every future workload will use.

## Target outcome

The organization can provide a new team with a governed subscription that has:

- a named business owner and technical owner;
- correct management-group placement;
- group-based access;
- inherited policy controls;
- an approved network and DNS path;
- central logs, alerts, and security visibility;
- a budget and required tags;
- a support, change, recovery, and retirement process.

## Phase 1: Discover requirements

Meet finance, security, identity, network, operations, compliance, and the first workload team. Record:

- the corporate Microsoft Entra tenant;
- the billing agreement and billing owner;
- approved Azure regions and data-residency limits;
- business-critical services and recovery objectives;
- existing identity, DNS, IP address, and on-premises network dependencies;
- security and compliance obligations;
- expected subscription count, growth, budget, and support hours;
- the people who approve platform and workload changes.

**Evidence:** approved requirements, stakeholder list, risk register, region list, IP address plan, and initial cost estimate.

**Exit condition:** unresolved tenant, billing, ownership, compliance, or connectivity questions have a named owner and target date.

## Phase 2: Define ownership and the operating model

Create a small platform team with clear responsibilities. A practical split is:

| Team | Main responsibility |
|---|---|
| Finance and procurement | Billing agreement, invoice access, budgets, and chargeback rules |
| Identity team | Entra ID, Conditional Access, PIM, emergency access, and identity lifecycle |
| Platform team | Management groups, subscriptions, Policy, shared services, Terraform, and releases |
| Network team | Address space, routing, DNS, egress, hybrid connectivity, and network incidents |
| Security team | Security standards, Defender decisions, findings, SIEM integration, and incident response |
| Operations team | Monitoring, alerts, backup oversight, service health, support, and recovery exercises |
| Workload owner | Workload design, data, application security, cost, availability, and remediation |

Define who is responsible, accountable, consulted, and informed for each platform service.

**Evidence:** operating model, responsibility matrix, support hours, escalation path, and change process.

**Exit condition:** every shared service and every control has an owner.

## Phase 3: Confirm tenant and billing

Use the approved corporate Entra tenant. Confirm the Enterprise Agreement, Microsoft Customer Agreement, or Cloud Solution Provider model that applies. Restrict subscription creation to the approved process.

Create and test two emergency-access accounts. Design Conditional Access and PIM separately from the Terraform in this repository.

**Evidence:** tenant ID, billing owner, subscription-creation owner, emergency-access test, and privileged-access design.

**Exit condition:** the team can prove which tenant and billing scope will contain every new subscription.

## Phase 4: Design management groups and subscriptions

Create an intermediate root below the tenant root. Use a hierarchy based on control requirements:

- `Platform`
  - Identity
  - Management
  - Connectivity
  - Security
- `Landing Zones`
  - Corp for workloads that need corporate or hybrid connectivity
  - Online for internet-facing workloads with a different connectivity model
- `Sandbox`
- `Decommissioned`

Keep the hierarchy flat. Do not create management groups for departments, regions, or environments unless they require a different policy or access model.

Use separate subscriptions for shared platform services and for workload lifecycle boundaries. Decide subscription names, owners, quotas, and placement before creation.

**Evidence:** approved hierarchy diagram, subscription register, placement rules, and owner for each subscription.

**Exit condition:** every planned subscription has a reason, owner, management-group destination, and cost owner.

## Phase 5: Design identity and access

Create Entra groups for platform roles. Assign the smallest useful Azure role at the smallest useful scope. Keep human administrator access separate from deployment identities.

Use PIM for eligible privileged roles. Use federated workload identity for GitHub Actions instead of stored client secrets. Review inherited access before assigning another role.

**Evidence:** role matrix, group owners, PIM settings, Conditional Access coverage, deployment-identity design, and access-review schedule.

**Exit condition:** no normal user needs permanent broad access to deploy or operate the platform.

## Phase 6: Design governance

Define required tags, approved regions, resource restrictions, diagnostic settings, public-access controls, and exemption rules. Start new policies in audit mode. Review impact, remediate existing findings, test allowed and denied deployments, and then introduce enforcement through change control.

An exemption must have a reason, owner, compensating control, approval, and expiry date.

**Evidence:** policy baseline, assignment scopes, compliance report, remediation plan, exemption register, and enforcement approval.

**Exit condition:** the platform team can explain what each policy controls, where it applies, and how a justified exception is handled.

## Phase 7: Design connectivity and DNS

Reserve non-overlapping address space. Decide whether hub-and-spoke or Virtual WAN meets the requirements. Define:

- hub and spoke address ranges;
- on-premises routes and return paths;
- VPN or ExpressRoute requirements;
- internet ingress and egress;
- Firewall, DDoS, NSG, and route ownership;
- Azure and on-premises DNS authority;
- private endpoint and private DNS behavior;
- resilience, capacity, monitoring, and cost.

This repository demonstrates hub-and-spoke, Firewall, Bastion, DNS Private Resolver, and private DNS options. Production circuits require a separate provider and resiliency design.

**Evidence:** network diagram, IP register, data flows, route tables, DNS query paths, firewall rules, failure scenarios, and cost approval.

**Exit condition:** network and DNS teams can trace an allowed flow in both directions and explain how it fails safely.

## Phase 8: Design security, management, and recovery

Choose approved Defender plans and decide whether Microsoft Sentinel or another SIEM receives security data. Define security contacts, finding ownership, public-access review, encryption and key ownership, vulnerability handling, and incident escalation.

Define central log destinations, retention, alert severity, on-call ownership, Service Health routing, backup responsibility, recovery time objectives, recovery point objectives, and recovery-test schedules.

**Evidence:** security baseline, log matrix, alert catalogue, on-call path, backup matrix, recovery plan, and test schedule.

**Exit condition:** every important signal, finding, backup, and recovery action has an owner and a test method.

## Phase 9: Build the delivery platform

Create protected remote Terraform state. Pin Terraform, providers, and modules. Use pull requests, required reviews, automated checks, saved plans, protected environments, and federated deployment identity.

For a production implementation, evaluate Microsoft's Azure landing zone IaC Accelerator and Azure Verified Modules. This repository remains a transparent learning implementation.

**Evidence:** protected state, pipeline identity, branch protection, successful checks, reviewed plan, release record, and rollback procedure.

**Exit condition:** a platform change can be reproduced from source control without using a developer's personal credentials.

## Phase 10: Deploy and validate the platform

Deploy the low-cost profile first. Validate names, tags, hub-spoke peering, routes, Activity Logs, Log Analytics, alerts, and budgets. Enable management groups and policy only with the required permissions. Add paid services only after design and cost approval.

Validate behavior, not only resource existence. Test DNS resolution, an expected network path, an alert notification, policy compliance, privileged access, and a recovery procedure.

**Evidence:** approved Terraform plan, apply output, resource inventory, CLI and portal checks, alert test, policy report, route and DNS tests, and recovery record.

**Exit condition:** all release checks pass and open exceptions are documented.

## Phase 11: Onboard the first workload subscription

Use a subscription-vending request to collect owner, environment, cost center, data classification, regions, connectivity, DNS, security, monitoring, and recovery needs.

Create or receive the subscription, place it in the correct management group, assign groups, apply a budget, connect approved networking, route required logs, validate inherited policy, and hand the subscription to the workload owner.

The workload team deploys its application in a separate repository. The platform team does not take ownership of the application.

**Evidence:** approved request, subscription record, placement, role assignments, budget, connectivity test, log test, policy result, and signed handover.

**Exit condition:** the first workload team can deploy within the agreed guardrails and knows where to request support or an exception.

## Phase 12: Operate and improve

Review critical alerts daily, policy and privileged activity weekly, access and cost monthly, and recovery and architecture decisions quarterly. Track service health, changes, incidents, exceptions, provider upgrades, and capacity.

Measure subscription delivery time, policy compliance, unresolved critical findings, alert delivery, access-review completion, recovery-test success, and cost variance.

**Final result:** Northwind can onboard future teams through a repeatable process instead of redesigning identity, governance, networking, monitoring, and delivery for every workload.

## Repository walkthrough

1. Read the root [README](../../README.md).
2. Record decisions using the [design areas](../02-design-areas/).
3. Complete [Labs 1 to 5](../04-labs/).
4. Use [Lab 6](../04-labs/lab-06-workload-onboarding.md) for the first subscription.
5. Validate with the [release checklist](../09-review/release-checklist.md).
6. Adopt the [day-2 operating schedule](../06-operations/day-2-operations.md).

Microsoft references: [Azure landing zone design areas](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas), [implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options), and [subscription vending](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending).
