# Lab 03: Management Groups and Subscription Placement

## Safety warning

Use a lab tenant. Management-group and policy changes can affect every subscription below the assignment scope.

## Goal

Create the reference hierarchy and deliberately place subscriptions.

## Steps

1. Review the hierarchy diagram.
2. Confirm the deployment identity has management-group permissions.
3. Set `deploy_management_groups = true`.
4. Add only known subscription IDs to `subscription_placements`.
5. Run a plan and inspect every management-group parent and subscription association.
6. Apply only after confirming the target tenant.
7. Verify policy inheritance paths in the portal.

## Design check

Explain why a subscription belongs under Corp, Online, Local, Sandbox, or a platform group. Do not place it based only on the department name.

