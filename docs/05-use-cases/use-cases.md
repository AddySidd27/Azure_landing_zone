# Landing Zone Use Cases

## 1. New Azure tenant

Establish tenant ownership, billing, management groups, platform subscriptions, policy, identity, connectivity, monitoring, and the subscription-vending process before large-scale workload onboarding.

[Follow the complete greenfield case](greenfield.md).

## 2. Existing ungoverned Azure environment

Inventory first. Identify subscriptions, owners, policies, RBAC, public exposure, networks, DNS, logs, security findings, and cost. Move toward the target architecture in controlled waves instead of rebuilding blindly.

[Follow the complete brownfield case](brownfield.md).

## 3. AVD workload

Place AVD resources in dedicated workload subscriptions. Consume shared DNS, connectivity, monitoring, and policy from the platform. Keep host pools, session hosts, FSLogix, images, and AVD scaling outside the platform repository.

## 4. Internet-facing application

Place the subscription under Online when it does not require the Corp connectivity model. Apply the correct public exposure, DDoS, application delivery, WAF, logging, and security controls.

## 5. Internal line-of-business application

Place the subscription under Corp when it requires corporate or hybrid connectivity. Document the DNS, routing, firewall, private endpoint, and identity dependencies.

## 6. Regulated workload

Use a dedicated subscription set and policy assignment scope when the workload needs distinct compliance, data residency, logging, encryption, or access controls. Do not add a management-group branch without a real policy difference.

## 7. Sandbox subscription

Provide a controlled experiment area with budget limits, reduced connectivity, expiration, ownership, and cleanup rules. Sandbox does not mean unmonitored or unlimited.

## 8. Multi-region workload

Keep the standard management-group hierarchy. Model regions in workload architecture, networking, data, recovery, and deployment pipelines rather than creating management groups solely for region names.

## 9. Hybrid DNS

Document the authoritative zones and query path. Use DNS Private Resolver and forwarding rules only when the approved design needs them. Test both Azure-to-on-premises and on-premises-to-Azure resolution.

## 10. Subscription decommissioning

Stop new deployment, identify owners and dependencies, preserve required logs/data, remove connectivity, revoke access, cancel resources, and move the subscription to Decommissioned before final cancellation.
