# Billing and Microsoft Entra Tenant

Tenant and billing decisions come before resource deployment.

## Tenant

The Microsoft Entra tenant is the identity boundary for users, groups, service principals, managed identities, and Azure subscriptions. Confirm whether the organization needs one tenant or has a justified multi-tenant requirement.

## Billing

The billing agreement controls how subscriptions are created and charged. Enterprise Agreement, Microsoft Customer Agreement, and Cloud Solution Provider models have different subscription-creation processes.

## Required decisions

- Authoritative tenant
- Billing owner
- Subscription naming and ownership
- Who can create subscriptions
- Chargeback or showback model
- Tenant-wide emergency access
- Restrictions on external identities

Do not create an extra tenant only to separate departments. Separate subscriptions and management groups are normally the first design tools; tenant separation requires a stronger identity, regulatory, or autonomy reason.

Microsoft reference: [Azure billing offers and Microsoft Entra tenants](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/azure-billing-microsoft-entra-tenant)
