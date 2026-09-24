# Subscription Vending

Subscription vending is the repeatable process that gives a workload team a governed subscription.

## Request

Collect workload name, owners, environment, data classification, cost center, region, connectivity model, address space, recovery requirements, and required policy exceptions. Select the `Corp`, `Online`, or optional `Local` archetype from the approved requirements.

## Automated actions

1. Create or identify the subscription.
2. Set subscription name and ownership metadata.
3. Place it in the correct archetype management group.
4. Assign workload-team groups at subscription scope.
5. Apply required tags, budget, and cost contacts.
6. Deploy standard diagnostics and security integration.
7. For Corp, allocate a non-overlapping spoke range, deploy the VNet, and connect it to the approved hub path.
8. For Online, deploy only the networking and controlled public exposure required by the workload.
9. Register the subscription in the platform inventory.

## Approval gates

- Billing and cost ownership
- Data/regulatory requirements
- Network address and connectivity
- Policy exemption, if any
- Production readiness

The workflow can begin manually and mature into a self-service process. The important point is that every subscription receives the same minimum metadata, controls, and ownership record.

The official Terraform option is `Azure/avm-ptn-alz-sub-vending/azure`, which supersedes the earlier `lz-vending` module. This repository documents and tests the process but does not create commercial-agreement subscriptions or deploy an automated vending product.

Microsoft references: [Subscription vending](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/subscription-vending) and [AVM subscription vending module](https://registry.terraform.io/modules/Azure/avm-ptn-alz-sub-vending/azure/latest).
