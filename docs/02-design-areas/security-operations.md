# Security Operations

Security tooling needs ownership and response processes.

## Defender for Cloud

Decide which Defender plans are required for each subscription and resource type. Enabling every paid plan without ownership or cost review is not a security strategy.

Define:

- coverage scope;
- plan owner and cost owner;
- recommendation triage;
- regulatory initiative requirements;
- alert routing;
- exemption handling;
- remediation service levels.

## Microsoft Sentinel

Use Sentinel when the security operating model needs centralized SIEM and SOAR. Decide which workspaces, data connectors, analytics rules, automation rules, playbooks, retention, and responders are required.

For a new ALZ design, place security tooling in a dedicated Security subscription below the Security management group. Keep the operational Log Analytics workspace in the Management subscription and use a separate security or Sentinel workspace when SecOps RBAC, cost ownership, or retention requirements differ. The earlier shared-workspace approach can remain valid for an existing environment when it meets the approved operating model.

The Terraform in this repository creates the Security management group and a security resource group, but it does not create a Security subscription, Sentinel workspace, or Sentinel configuration.

## Security baseline

- Microsoft cloud security benchmark
- Defender for Cloud recommendations
- Activity and resource logs
- Vulnerability management
- Patch and configuration drift
- Encryption and key ownership
- Network segmentation and inspection
- Incident response
- Evidence retention

## Shared responsibility

The platform team supplies shared controls. Security owns detection and response requirements. Workload teams remain responsible for application code, data, secrets, patching, and workload recovery.

Microsoft references: [Security design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/security) and [Security management group and subscription update](https://techcommunity.microsoft.com/blog/azuregovernanceandmanagementblog/a-new-platform-management-group--subscription-for-security-in-azure-landing-zone/4433287).
