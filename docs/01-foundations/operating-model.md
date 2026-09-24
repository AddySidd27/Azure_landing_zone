# Cloud Operating Model

A strong architecture needs clear ownership. Tools do not replace an operating model.

| Responsibility | Platform team | Workload team | Security/governance |
|---|---|---|---|
| Management-group design | Accountable | Consulted | Consulted |
| Subscription vending | Accountable | Requests | Reviews controls |
| Shared connectivity | Accountable | Supplies requirements | Reviews exposure |
| Workload resources | Provides guardrails | Accountable | Monitors compliance |
| Platform monitoring | Accountable | Consumes/integrates | Reviews incidents |
| Application monitoring | Provides standards | Accountable | Reviews critical findings |
| Policy baseline | Implements | Tests impact | Owns requirements |
| Cost ownership | Shared services | Workload consumption | Governance/reporting |

## Decisions to record

- Who approves new subscriptions?
- Who owns connectivity and DNS?
- Who approves policy exemptions?
- Who receives platform alerts?
- Who can activate privileged roles?
- Who pays for shared services?
- Who updates Terraform and provider versions?
- Who declares a platform incident?

Record these decisions in architecture decision records. A generic diagram cannot answer them.

