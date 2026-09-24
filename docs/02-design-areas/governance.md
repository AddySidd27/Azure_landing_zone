# Governance

Azure Policy provides guardrails across deployment tools. A resource created from the portal, Terraform, Bicep, or an API is evaluated by the same assigned policy.

## Safe rollout

```text
Requirement -> Audit -> Measure -> Remediate -> Exception process -> Enforce
```

Do not begin with a broad deny assignment in a production hierarchy. Test the policy definition, assignment scope, parameters, exclusions, effects, and remediation behavior.

## Policy record

For each assignment record:

- business or regulatory requirement;
- owner;
- scope;
- effect;
- parameters;
- non-compliance message;
- remediation method;
- exemption approver and expiry;
- review date.

Prefer built-in policies when they meet the requirement. Custom policies create a maintenance responsibility.

## Policy-driven hierarchy

Azure landing zones use inheritance to layer policy. Organization-wide controls start near the intermediate root, shared-service controls apply below Platform, workload-independent controls apply below Landing Zones, and archetype-specific controls apply below Corp, Online, or Local.

Use these effects deliberately:

- `Audit` reports noncompliance without blocking the resource.
- `Deny` blocks a request that violates the condition.
- `Modify` changes supported properties or tags.
- `DeployIfNotExists` deploys a related configuration when the required configuration is missing.

`Modify` and `DeployIfNotExists` remediation require an assignment identity and the roles needed to change the target resources. Test the identity, scope, and remediation behavior before production enforcement.

The detailed [ALZ policy model](../08-reference/alz-policy-model.md) explains conceptual policy layers. The [Azure Landing Zones Library](https://github.com/Azure/Azure-Landing-Zones-Library) remains the authoritative source for current ALZ policy and archetype assets.

Microsoft reference: [Governance design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/governance)
