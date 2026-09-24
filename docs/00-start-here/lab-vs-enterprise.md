# Lab Versus Enterprise

The same design principles apply, but a personal lab cannot reproduce every enterprise boundary.

| Area | Core lab | Enterprise target |
|---|---|---|
| Subscriptions | One existing subscription | Separate platform and workload subscriptions |
| Management groups | Explained; optional controlled exercise | Standard hierarchy with governed subscription placement |
| Connectivity | Hub and one spoke | Dedicated connectivity subscription and many workload spokes |
| Firewall | Disabled by default | Enabled only when required by the approved network design |
| DNS | Azure-provided DNS by default | Central private DNS and hybrid resolution where required |
| Identity | Current user/service principal | Federated deployment identity, PIM, access reviews, break-glass design |
| Monitoring | One workspace | Central workspace strategy, diagnostic policy, alerts, retention and ownership |
| Policy | Safe audit examples | Initiatives, staged enforcement, exemptions, remediation and evidence |
| State | Dedicated storage account | Protected state subscription/resource group with CI access controls |

Do not present the core lab as a complete production landing zone. Use it to prove the deployment workflow and explain how the enterprise target differs.

