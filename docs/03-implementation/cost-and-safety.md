# Cost and Safety

The core lab disables the highest-cost shared services by default. The full-platform profile enables services that can continue charging while idle.

## Review before apply

- Azure Firewall hourly and data-processing charges
- Azure Bastion hourly charges
- DNS Private Resolver endpoint charges
- Log Analytics ingestion and retention
- Public IP addresses
- Key Vault operations and private endpoints
- Network egress

Use the Azure Pricing Calculator for the selected region and current prices. Repository estimates become stale, so this project does not hard-code a dollar claim.

## Cost controls

- Configure a subscription budget and real notification contacts.
- Tag shared services and document cost ownership.
- Destroy short-lived lab resources when testing is complete.
- Do not assume a stopped service has no platform charge.
- Review Cost Management after the deployment and again after usage data arrives.

## Safety controls

- Use a dedicated lab subscription.
- Start policies in audit mode.
- Keep management-group deployment disabled until tenant permissions are understood.
- Review every default route before enabling Firewall.
- Confirm DNS targets instead of inventing IP addresses.
- Keep personal values out of committed tfvars files.

