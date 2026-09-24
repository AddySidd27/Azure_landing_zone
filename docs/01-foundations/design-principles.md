# Azure Landing Zone Design Principles

Microsoft's landing-zone design principles guide decisions when requirements change. They are not a fixed list of Azure services.

## Subscription democratization

Use subscriptions as management and isolation boundaries. Give workload teams enough control to deliver their applications while platform policy, security, monitoring, and connectivity provide guardrails.

A mature platform provides a repeatable subscription-vending process. The process can begin with a controlled request workflow and later become self-service.

## Policy-driven governance

Use Azure Policy to audit and enforce technical controls regardless of whether a resource is created through the portal, Terraform, Bicep, CLI, or an API.

Policy does not replace architecture review. Every assignment still needs an owner, scope, parameters, rollout plan, exemption process, and test method.

## Single control and management plane

Use Azure Resource Manager as the consistent control plane for Azure resources. Apply RBAC and policy through this plane instead of building unnecessary custom management layers.

## Application-centric service model

Organize workload subscriptions around workload requirements. Do not create permanent silos only for individual Azure services or reproduce the company organization chart in management groups.

## Azure-native alignment

Prefer Azure-native capabilities when they satisfy the requirement and operating model. A third-party product can still be appropriate, but document the integration, ownership, lifecycle, and support impact.

Microsoft reference: [Azure landing zone design principles](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles)

