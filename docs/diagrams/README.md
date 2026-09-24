# Architecture Diagrams

Start with the conceptual architecture below. It shows the tenant hierarchy, shared platform capabilities, guardrails, automation, and operating model. Use the remaining diagrams for individual design decisions.

The management-group hierarchy diagram includes the current reference branches used by this repository: Identity, Management, Connectivity, and Security below Platform; Corp, Online, and Local below Landing Zones; plus Sandbox and Decommissioned.

![Azure enterprise landing zone](svg/01-conceptual-architecture.svg)

## Diagram library

| Diagram | Editable source | GitHub preview | High-resolution PNG |
|---|---|---|---|
| Conceptual architecture | [draw.io](source/01-conceptual-architecture.drawio) | [SVG](svg/01-conceptual-architecture.svg) | [PNG](png/01-conceptual-architecture.png) |
| Management-group hierarchy | [draw.io](source/02-management-group-hierarchy.drawio) | [SVG](svg/02-management-group-hierarchy.svg) | [PNG](png/02-management-group-hierarchy.png) |
| Hub-and-spoke topology | [draw.io](source/03-hub-spoke-topology.drawio) | [SVG](svg/03-hub-spoke-topology.svg) | [PNG](png/03-hub-spoke-topology.png) |
| Subscription vending | [draw.io](source/04-subscription-vending.drawio) | [SVG](svg/04-subscription-vending.svg) | [PNG](png/04-subscription-vending.png) |
| Platform delivery workflow | [draw.io](source/05-delivery-workflow.drawio) | [SVG](svg/05-delivery-workflow.svg) | [PNG](png/05-delivery-workflow.png) |
| Policy inheritance | [draw.io](source/06-policy-inheritance.drawio) | [SVG](svg/06-policy-inheritance.svg) | [PNG](png/06-policy-inheritance.png) |
| DNS resolution flow | [draw.io](source/07-dns-resolution-flow.drawio) | [SVG](svg/07-dns-resolution-flow.svg) | [PNG](png/07-dns-resolution-flow.png) |
| Monitoring flow | [draw.io](source/08-monitoring-flow.drawio) | [SVG](svg/08-monitoring-flow.svg) | [PNG](png/08-monitoring-flow.png) |
| Privileged access | [draw.io](source/09-privileged-access.drawio) | [SVG](svg/09-privileged-access.svg) | [PNG](png/09-privileged-access.png) |
| Multi-region responsibilities | [draw.io](source/10-multi-region.drawio) | [SVG](svg/10-multi-region.svg) | [PNG](png/10-multi-region.png) |
| Brownfield migration | [draw.io](source/11-brownfield-migration.drawio) | [SVG](svg/11-brownfield-migration.svg) | [PNG](png/11-brownfield-migration.png) |
| AVD workload integration | [draw.io](source/12-avd-workload-integration.drawio) | [SVG](svg/12-avd-workload-integration.svg) | [PNG](png/12-avd-workload-integration.png) |

The `.drawio` files are the editable sources. Open them in draw.io or diagrams.net. The SVG files are the GitHub previews, and the PNG files are useful in presentations.

When the architecture changes:

1. Update the matching `.drawio` source.
2. Export a new SVG and PNG with the same file name.
3. Check that labels are readable at normal GitHub width.
4. Update the related guide if the design decision changed.

These diagrams explain a reference design. They do not prove that an Azure environment is compliant or production-ready.
