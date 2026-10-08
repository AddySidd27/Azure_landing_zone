# Platform Automation and DevOps

Infrastructure as code gives the platform a reviewed, repeatable history. Microsoft's design area aims to line up DevOps practice with the landing zone lifecycle: provisioning, management, evolution, and operations.

## Minimum decisions

- Which implementation path: the IaC accelerator (Bicep or Terraform with Azure Verified Modules) or the portal accelerator?
- Which version control system and pipeline service: Azure DevOps or GitHub?
- Who reviews a change, and how many approvals does a protected branch need?
- Which identity does each pipeline use, per application and environment?
- Which test environment receives a change before production?
- Who may change anything outside the pipeline, and when?
- How do workload teams ask for a policy exemption?

## Delivery flow

My own delivery flow, not a Microsoft diagram:

```text
Issue -> Branch -> Format and validate -> Security checks -> Plan -> Review -> Approval -> Apply -> Verify
```

## Controls from Microsoft Learn

- Keep all code in version control: infrastructure, policy, configuration, deployment, and documentation.
- Use peer review (the 4-eyes principle) and pull requests into a protected branch.
- Run CI/CD for checks, test deployments, and deployment to each environment.
- Deploy only through continuous delivery pipelines, not from local machines.
- Use separate identities for plan or what-if (read access) and for apply or deploy (write access).
- Authenticate pipelines with OpenID Connect (workload identity federation), a separate identity per application and environment, and never a user account or client secret.
- In Azure DevOps, put approvals on the service connection, not on the environment. In GitHub, put approvals on the Actions environment.
- Keep secrets out of code. If a secret is unavoidable, keep it in a store such as Azure Key Vault.
- Use human approval for the production deploy stage and read the plan or what-if output.
- Use the same code for every environment, with variables to tell them apart. Do not copy code between folders.
- Have at least one test environment, and use separate service principals for test and production.
- Make changes outside the code only in an emergency, record quick fixes in the backlog, and expect the next IaC run to show the drift.
- Manage Azure Policy as code and set up an exemption process.

## My own practice (not from the Learn pages for this design area)

These are habits I use in my own work. Microsoft Learn does not state them on the pages this note is based on.

- Store remote state with controlled access and recovery features.
- Save a plan only for the environment it was made for.
- Pin tool and module versions, and review upgrades before accepting them.

## Production extensions

Microsoft recommends infrastructure as code and documents the Azure Landing Zones IaC Accelerator as the recommended implementation path. It also notes that accelerators have a limited management scope, so plan a layer of automation for what your workload teams need. This repository remains readable for learning and explains where a production team should use the accelerator or AVM modules.

The portal accelerator suits teams without IaC skills. Microsoft says it is less flexible and scalable, and that updates and version control are hard to manage without IaC.

Microsoft references: [Platform automation and DevOps](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/platform-automation-devops), [Platform automation](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/automation), [Use infrastructure as code to update an Azure landing zone](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/infrastructure-as-code-updates), [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options), and [Security considerations for DevOps platforms](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/security-considerations-overview).
