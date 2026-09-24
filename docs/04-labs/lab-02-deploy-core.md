# Lab 02: Deploy the Core Landing Zone

## Goal

Deploy a low-cost platform foundation without Firewall, Bastion, or DNS Private Resolver.

## Expected resources

- Connectivity and management resource groups
- Hub and workload-spoke VNets
- Reserved platform subnets
- Hub/spoke peering
- Workload NSG and route table
- Log Analytics workspace
- Action Group foundation
- Subscription activity-log diagnostics
- Subscription budget

## Steps

1. Copy and edit the core-lab backend and tfvars examples.
2. Run initialization, format check, validation, and plan.
3. Verify that paid optional services show as disabled.
4. Apply the saved plan.
5. Run the commands in the deployment guide.
6. Inspect peering status in the portal.
7. Confirm subscription Activity Log categories target the workspace.

## Success evidence

- Both peerings show `Connected`.
- Hub and spoke address spaces do not overlap.
- Workload subnet has its NSG and route table.
- Log Analytics workspace exists with the selected retention.
- Terraform output matches the deployed resource IDs.

