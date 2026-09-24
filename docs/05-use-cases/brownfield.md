# End-to-End Use Case 2: Govern an Existing Azure Environment

## Situation

Contoso has 45 Azure subscriptions created by different teams. Ownership is incomplete, role assignments are broad, address ranges overlap, diagnostic settings vary, some resources allow public access, and several deployments are manual.

The organization wants one governed platform without interrupting production services.

## Target outcome

Existing subscriptions move to an approved hierarchy in controlled waves. Critical workloads keep working, exceptions are visible and time limited, central operations gain reliable telemetry, and all new subscriptions use the standard vending process.

## Rule for the migration

Do not move every subscription, enforce every policy, or change every network path in one release. Inventory first, create visibility, test in audit mode, migrate a low-risk pilot, and keep a rollback path for every wave.

## Phase 1: Establish authority and freeze uncontrolled growth

Name the executive sponsor, migration lead, platform owner, security owner, network owner, and subscription owners. Introduce a temporary review for new subscriptions, new public endpoints, new peerings, and broad role assignments while discovery is in progress.

Do not freeze normal business delivery. Control only changes that can make the migration risk larger.

**Evidence:** migration charter, decision owners, temporary controls, communication plan, and escalation path.

**Exit condition:** the migration team has authority to inspect the estate and coordinate production changes.

## Phase 2: Build the current-state inventory

Collect:

- tenant and billing ownership;
- subscriptions, management-group placement, business owners, technical owners, and cost centers;
- role assignments, custom roles, service principals, managed identities, and privileged access;
- policy assignments, initiatives, exemptions, and compliance;
- VNets, CIDRs, peerings, gateways, route tables, Firewalls, private endpoints, public IPs, and DNS zones;
- Activity Log destinations, diagnostic settings, workspaces, alerts, and retention;
- Defender plans, security findings, Key Vaults, encryption dependencies, and SIEM connections;
- backups, recovery objectives, recovery tests, and regional dependencies;
- tags, budgets, reservations, and cost anomalies;
- Terraform, Bicep, ARM templates, scripts, pipelines, state files, and manually managed resources.

Record business criticality and maintenance windows. A resource graph or spreadsheet is useful, but each item still needs a named owner.

**Evidence:** subscription register, resource inventory, identity review, network and DNS diagrams, policy baseline, security baseline, monitoring map, cost baseline, and automation inventory.

**Exit condition:** no production subscription is classified as ownerless or dependency-unknown.

## Phase 3: Classify risks and dependencies

Rank findings by business impact. Address exposed credentials, unmanaged privileged access, critical public exposure, missing backups, and broken logging through the incident or urgent-change process. Do not wait for the full landing-zone migration to fix an immediate risk.

Map dependencies between subscriptions, on-premises systems, identity, DNS, routes, firewalls, private endpoints, third parties, and deployment pipelines.

**Evidence:** risk register, dependency map, critical-remediation records, and proposed migration waves.

**Exit condition:** each migration wave has known dependencies, an owner, a test plan, and a rollback decision.

## Phase 4: Approve the target platform design

Confirm the corporate tenant and billing model. Define the target management-group hierarchy, platform subscriptions, access model, policy baseline, network and DNS architecture, central monitoring, security operations, cost controls, and platform operating model.

Decide what will be reused, moved, rebuilt, or retired. Avoid forcing a new service into the design when an existing service is supportable and meets the approved requirements.

**Evidence:** target architecture, decision records, ownership matrix, subscription placement map, policy plan, network migration plan, and cost approval.

**Exit condition:** current and target states can be compared subscription by subscription.

## Phase 5: Create the landing-zone foundation beside production

Create the target management groups and dedicated platform subscriptions without moving critical workload subscriptions. Establish protected Terraform state and pipeline identity. Deploy central management, connectivity, and security capabilities in stages.

Connect log sources and dashboards before enforcement so that the team can see the effect of later changes.

**Evidence:** platform plan, deployed hierarchy, protected state, pipeline results, resource inventory, and operational checks.

**Exit condition:** the target platform is available and tested without changing a critical production path.

## Phase 6: Introduce governance in audit mode

Assign the proposed policy baseline in audit or non-enforcing mode at a safe scope. Measure compliance, identify false assumptions, and separate real violations from justified exceptions.

Create remediation tasks where appropriate. Every exemption requires an owner, business reason, compensating control, approval, and expiry date.

**Evidence:** before-and-after compliance reports, remediation backlog, exemption register, and enforcement proposal.

**Exit condition:** the expected effect of enforcement is known for every subscription in the next wave.

## Phase 7: Run a low-risk pilot wave

Choose one non-critical subscription with a cooperative owner and representative controls. Before the move:

1. export inherited role and policy assignments;
2. capture routes, DNS behavior, log flow, alerts, cost, and application health;
3. confirm the maintenance window and rollback owner;
4. move the subscription to the target management group;
5. apply only the approved controls;
6. test access, deployment, network, DNS, monitoring, backup, and application health;
7. observe the subscription for the agreed period.

**Evidence:** change approval, pre-checks, move record, validation results, incidents, rollback decision, and lessons learned.

**Exit condition:** the pilot is stable and its lessons are included in the next wave plan.

## Phase 8: Migrate connectivity and DNS carefully

Network changes can interrupt many workloads at once. Resolve overlapping address space and confirm return routes before peering or transit changes. Test firewall rules, user-defined routes, DNS forwarding, private DNS links, private endpoints, VPN or ExpressRoute paths, and failover.

Use parallel paths or staged cutovers where the design permits. Keep the old path until validation succeeds and rollback time has not expired.

**Evidence:** approved data flows, route comparison, DNS tests, firewall logs, latency and capacity checks, cutover record, and rollback result.

**Exit condition:** workloads use the approved path and the obsolete path can be removed safely.

## Phase 9: Migrate subscriptions in controlled waves

Group subscriptions by dependency and risk, not only by department. A practical order is:

1. sandbox and development;
2. non-critical test and shared services;
3. low-risk production;
4. business-critical production;
5. subscriptions with complex network, regulatory, or vendor dependencies.

For every wave, repeat the pre-check, change, functional validation, monitoring period, and closure process. Pause if the agreed failure threshold is reached.

**Evidence:** wave plan, per-subscription checklist, compliance results, access review, application approval, incident record, and closure report.

**Exit condition:** each migrated subscription meets the target baseline or has an approved time-limited exception.

## Phase 10: Move from audit to enforcement

Enforce one policy group at a time after remediation and testing. Start with controls that have clear behavior and low operational risk. Schedule high-impact controls separately.

Test one deployment that should succeed and one that should be denied. Monitor support requests and deployment failures after each change.

**Evidence:** enforcement approval, policy version, positive and negative tests, exception records, and post-change review.

**Exit condition:** enforcement protects the estate without creating unexplained deployment failures.

## Phase 11: Standardize delivery and stop new drift

Adopt the subscription-vending process for every new subscription. Move platform source to reviewed pipelines with federated identity. Import or carefully replace manually managed platform resources only when ownership and lifecycle are clear.

Do not import every workload resource into the platform state. Platform and workload teams keep separate code and state boundaries.

**Evidence:** vending request and handover, pipeline controls, state ownership map, repository ownership, and release process.

**Exit condition:** new subscriptions and platform changes follow the target model by default.

## Phase 12: Retire temporary and duplicate components

After migrations are stable, remove old peerings, routes, log destinations, duplicate workspaces, obsolete identities, unused policies, and temporary exemptions. Preserve required logs and records. Use the approved decommissioning process.

**Evidence:** final dependency check, removal plan, retained-data record, cost comparison, and decommission approval.

**Exit condition:** there is no hidden dependency on the old platform path.

## Phase 13: Operate and measure the platform

Track policy compliance, privileged access, critical findings, alert delivery, subscription delivery time, migration exceptions, recovery-test success, and cost variance. Review exceptions and remaining legacy subscriptions on a fixed schedule.

**Final result:** Contoso has moved from inconsistent Azure usage to a governed platform through measured changes, without treating production as a clean installation.

## Example migration record

| Field | Example |
|---|---|
| Subscription | `sub-payroll-prod` |
| Business owner | Finance director |
| Technical owner | Payroll service team |
| Target placement | `Landing Zones/Corp` |
| Main dependencies | On-premises payroll, corporate DNS, private database endpoint |
| Pre-change evidence | Routes, DNS tests, access export, alert test, backup status |
| Planned change | Management-group move, central diagnostics, approved policy baseline |
| Rollback trigger | Payroll health check fails or corporate DNS resolution fails |
| Observation period | One complete payroll processing cycle |
| Closure evidence | Owner approval, compliance result, cost owner, support handover |

Microsoft reference: [Transition an existing Azure environment](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/transition).
