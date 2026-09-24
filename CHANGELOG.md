# Changelog

## [Unreleased]

### Added

- Added the five Cloud Adoption Framework landing-zone design principles to the main guide.
- Added Corp, Online, and Local archetype explanations and guardrail examples.
- Added the dedicated Security management-group and subscription operating model.
- Added a custom-learning versus official ALZ AVM and accelerator comparison.
- Added the ALZ policy hierarchy model, policy-effect guidance, and a reference glossary.
- Added production guidance for AMBA, AMA and DCRs, Service Health alerts, Update Manager, and private endpoint DNS at scale.
- Added the current AVM subscription-vending option and explicit archetype, RBAC, tag, budget, and connectivity actions.

### Changed

- Updated repository URLs and clone commands to `AddySidd27/Azure_landing_zone`.
- Aligned the README, detailed guides, source review, coverage matrix, and diagram descriptions with the implemented management-group hierarchy.
- Clarified which guidance is implemented by Terraform and which remains production design guidance.

### Fixed

- Corrected the core-lab Terraform test to compare the hub address space without assuming a list type.
- Removed the empty root tests-folder entry from the repository map.

## 1.4.0 - 2026-09-23

### Changed

- Added a practical example and validation check to every platform capability.
- Added the official Microsoft hub-and-spoke Azure landing zone reference architecture with attribution.
- Kept the simplified platform diagram as the repository-specific learning view.

## 1.3.0 - 2026-09-23

### Changed

- Refocused the repository on the Azure landing zone platform foundation.
- Rebuilt the README around scope, capabilities, architecture, deployment, validation, scenarios, and operations.
- Removed role-preparation wording and kept the content focused on platform engineering.
- Replaced workload-framework terminology with direct subscription and platform language.
- Redesigned the primary architecture diagram as a platform-only view.
- Renamed the AVD example as workload integration and kept its resources outside the platform scope.

## 1.2.0 - 2026-09-23

### Changed

- Expanded the main README with the landing-zone concept, lifecycle, business value, and direct navigation.
- Consolidated the design explanation into the main README.
- Rewrote ten use cases with the problem, landing-zone response, and success evidence.
- Added direct links to every maintained repository folder.
- Replaced obsolete Microsoft Learn URLs and verified every documentation URL live.
- Added repository security, support, code-of-conduct, and link-checking files.

## 1.1.0 - 2026-09-23

### Changed

- Rebuilt the root README as one start-to-finish learning path.
- Added a visible Microsoft Learn source map and design-area coverage table.
- Brought deployment, validation, use cases, labs, operations, cleanup, and design explanation into the main guide.
- Redesigned the conceptual architecture diagram and made it the entry point to the diagram library.
- Removed tool-generation wording from repository checks.

## 1.0.1 - 2026-09-23

### Fixed

- Updated Log Analytics public-access arguments for AzureRM 5.x.
- Updated Key Vault private DNS virtual-network links to use the AzureRM 5.x zone ID schema.

## 1.0.0 - 2026-09-19

### Added

- Low-cost core-lab and full-platform configurations
- Remote Terraform state bootstrap
- Management-group and subscription-placement foundation
- Hub-and-spoke networking with optional Firewall, Bastion, DNS Private Resolver, and Key Vault private endpoint
- Optional Defender for Cloud plan configuration
- Central Log Analytics, Activity Log diagnostics, Action Group, and subscription budget
- Ten guided labs and detailed greenfield, brownfield, AVD, subscription-vending, and decommissioning use cases
- Microsoft landing-zone design-area and design-principle guides
- Day-2 operations, troubleshooting, recovery, validation, and design explanation
- Twelve editable draw.io diagrams with SVG and PNG exports
- GitHub Actions validation and native Terraform mock-plan tests

### Validation status

- Terraform formatting passed locally.
- Repository, link, diagram XML, SVG, and artifact checks passed locally.
- Provider-schema validation and Terraform tests must pass in GitHub Actions before the release is tagged as deployable.
- An authenticated Azure plan and apply remain environment-owner activities.
