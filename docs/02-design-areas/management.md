# Management and Monitoring

Management covers visibility, operational compliance, protection, and recovery.

## Minimum decisions

- Which logs are required?
- Where are they stored?
- How long are they retained?
- Who can query them?
- Which alerts require action?
- Who receives each severity?
- What is the recovery objective?
- How are platform changes and drift reviewed?

Creating a Log Analytics workspace is not a monitoring solution. Resources need diagnostic settings or another supported data path, queries need owners, and alerts need tested receivers and response procedures.

## Production extensions

- Azure Monitor Baseline Alerts for Azure landing zones provides a policy-driven baseline for platform alerts.
- Azure Monitor Agent collects required VM telemetry according to Data Collection Rules. The legacy Log Analytics agent is retired.
- Service Health alerts should notify the correct owners for every subscription.
- Azure Update Manager provides update assessment and scheduled patching for supported Azure and Azure Arc-enabled machines.

These items are design guidance only. This repository's Terraform deploys a Log Analytics workspace, subscription Activity Log diagnostics, an Action Group, and a budget; it does not deploy AMBA, AMA, DCRs, Service Health alerts, or Update Manager schedules.

Microsoft references: [Management design area](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management), [AMBA for ALZ](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/management-monitor), [Azure Monitor Agent](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-overview), [Service Health alerts](https://learn.microsoft.com/en-us/azure/service-health/alerts-activity-log-service-notifications-portal), and [Azure Update Manager](https://learn.microsoft.com/en-us/azure/update-manager/overview).
