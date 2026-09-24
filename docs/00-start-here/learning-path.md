# Learning Path

Follow the repository in this order. Do not begin with `terraform apply`.

## Phase 1: Understand the platform and requirements

1. What an Azure landing zone is.
2. Platform scope and workload-subscription boundaries.
3. Tenant, billing, subscriptions, and management groups.
4. The cloud operating model and ownership boundaries.
5. Business, compliance, region, recovery, connectivity, and cost requirements.

## Phase 2: Make the design decisions

Review every Microsoft landing-zone design area:

1. Billing and Microsoft Entra tenant
2. Identity and access management
3. Resource organization
4. Network topology and connectivity
5. Security
6. Management and monitoring
7. Governance
8. Platform automation and DevOps

Record decisions before implementation. A landing zone is not a list of Azure services; it is an operating model supported by architecture and automation.

## Phase 3: Build safely

1. Create the deployment identity.
2. Bootstrap remote Terraform state.
3. Select the core-lab or full-platform configuration.
4. Run formatting, initialization, validation, and plan.
5. Review the plan.
6. Apply the approved plan.
7. Validate resources in Azure.

## Phase 4: Onboard a workload

Use the workload-onboarding lab to place a subscription, apply inherited controls, connect the workload network, send logs to the management platform, and confirm ownership.

## Phase 5: Operate the platform

Practice policy review, access review, alert handling, cost review, drift detection, platform updates, incident response, and decommissioning.

## Phase 6: Apply the complete process

Finish with the two end-to-end cases:

1. [Build Azure from the beginning](../05-use-cases/greenfield.md)
2. [Govern an existing Azure environment](../05-use-cases/brownfield.md)

The first case shows a clean platform build. The second shows how to reach the same target without disrupting an existing estate.
