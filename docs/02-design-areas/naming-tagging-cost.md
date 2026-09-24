# Naming, Tagging, and Cost Management

## Naming

Use names that help engineers identify the resource type, workload or platform capability, environment, region, and instance where those fields are useful. Keep the convention short enough for services with strict name limits.

Example:

```text
rg-contoso-connectivity-prod-eastus2
vnet-contoso-hub-prod-eastus2
law-contoso-prod-eastus2
```

Names do not replace tags, subscriptions, or inventory. Some Azure resource names cannot be changed, so review naming before deployment.

## Tags

Useful tags can include owner, application, environment, cost center, data classification, business criticality, and managed-by. Decide which resources support them and whether policy should append, inherit, audit, or deny missing values.

Do not store secrets or personal data in tags.

## Cost

- Give every subscription a cost owner.
- Apply budgets at useful scopes.
- Use tags and subscription structure for reporting.
- Review shared-service allocation.
- Investigate anomalies and unused resources.
- Include cost impact in architecture and change reviews.

Microsoft references: [Naming and tagging](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) and [Cost management discipline](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/govern/cost-management/)

