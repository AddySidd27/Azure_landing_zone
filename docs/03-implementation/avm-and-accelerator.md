# IaC Accelerator and Azure Verified Modules

Microsoft recommends an infrastructure-as-code approach for platform landing zones when the organization can operate it.

## Azure Landing Zones IaC Accelerator

The accelerator helps bootstrap the Azure environment and the selected version-control platform. Microsoft describes four phases:

1. Planning
2. Prerequisites
3. Bootstrap
4. Run and customize

It supports Terraform or Bicep implementations built around Azure Verified Modules.

## Azure Verified Modules

AVM modules provide supported patterns and consistent interfaces for Azure resources and platform landing zones. Pin versions, read release notes, test upgrades, and avoid assuming that a verified module removes the need for architecture decisions.

The official Terraform approach composes pattern modules. Current examples include:

- `Azure/avm-ptn-alz/azurerm` for management groups, policy, and role assignments;
- ALZ management resources;
- ALZ hub-and-spoke or Virtual WAN connectivity patterns;
- gateway and Private Link private DNS patterns;
- `Azure/avm-ptn-alz-sub-vending/azure` for subscription vending.

The ALZ Terraform provider processes assets from the Azure Landing Zones Library, including archetypes, policies, role definitions, and architecture definitions. Confirm current module names, versions, and provider constraints in the official module index before implementation.

The older `Azure/caf-enterprise-scale/azurerm` module was superseded by this modular AVM approach and reached its announced archive date. Existing implementations should follow the [official migration guide](https://aka.ms/alz/tf/migrate). A corresponding AVM-based Bicep accelerator is available.

## How this repository fits

This repository is a readable learning implementation. It explains concepts and exposes resource relationships directly. For a real enterprise rollout, compare its requirements with the IaC Accelerator and AVM platform landing-zone module before selecting the production codebase.

| Aspect | This repository | Official ALZ implementation |
|---|---|---|
| Goal | Learning and transparent examples | Production platform deployment and lifecycle |
| Policy | One controlled example | Azure Landing Zones Library and archetype model |
| Network | Small hub-and-spoke example | Composable hub-and-spoke and Virtual WAN patterns |
| Delivery | Validation workflow and documented OIDC | Accelerator-created state, identities, and pipelines |
| Maintenance | Repository owner tests all changes | Versioned modules, library, provider, and migration guidance |

Use this repository to understand how the components work. Use the official accelerator and AVM modules as the production starting point, then tailor the result to approved requirements.

Microsoft references: [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options), [official Terraform documentation](https://azure.github.io/Azure-Landing-Zones/terraform/), and [Azure Landing Zones Library](https://github.com/Azure/Azure-Landing-Zones-Library).
