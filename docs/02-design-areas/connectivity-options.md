# Hub-Spoke, Virtual WAN, VPN, and ExpressRoute

Choose connectivity from requirements, not from a diagram preference.

| Requirement | Typical option |
|---|---|
| Controlled regional hub with explicit routing | Hub-and-spoke |
| Large global branch and transit estate | Azure Virtual WAN |
| Encrypted connectivity over the internet | Site-to-site VPN |
| Private dedicated connectivity through a provider | ExpressRoute |
| Temporary user or administrator connection | Point-to-site VPN, Bastion, or approved secure access pattern |

## Questions before selection

- Number of regions, sites, and branches
- Required throughput and latency
- Availability and recovery requirements
- Encryption requirements
- Routing ownership and BGP capability
- Internet and east-west inspection
- DNS dependencies
- Operational team experience
- Provider lead time and cost

ExpressRoute is not internet access, and it is not automatically encrypted end to end. VPN and ExpressRoute can coexist when the availability design requires it.

Microsoft reference: [Network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity)

