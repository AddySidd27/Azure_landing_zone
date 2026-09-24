# Network Topology and Connectivity

The repository demonstrates hub-and-spoke because it makes shared connectivity and workload separation easy to study. Azure Virtual WAN can be a better choice for large global branch and transit requirements.

## Hub responsibilities

The hub can contain shared services such as Azure Firewall, VPN or ExpressRoute gateways, DNS Private Resolver, Bastion, and selected private endpoints. Workload servers do not belong in the hub.

## Spoke responsibilities

Each spoke belongs to a workload subscription. Its team owns workload subnets, local NSGs, application routes, and service-specific private endpoints within platform standards.

## Decisions before deployment

- Non-overlapping address plan
- Hub-spoke or Virtual WAN
- Internet egress path
- East-west inspection requirements
- Hybrid connectivity
- DNS authority and forwarding path
- Private endpoint ownership
- DDoS protection requirements
- Region and recovery topology

Creating a firewall does not automatically inspect traffic. Workload route tables, peering settings, firewall rules, and return paths must form a complete traffic path.

## Private endpoint DNS at scale

Host shared Private Link private DNS zones in the Connectivity subscription. Workload teams can create private endpoints in their subscriptions without receiving write access to central DNS zones. Azure Policy can use `DeployIfNotExists` to connect the private endpoint to the matching central zone and create the required DNS configuration. DNS Private Resolver supports conditional forwarding between Azure and on-premises DNS.

This repository creates one Key Vault private DNS example and can deploy DNS Private Resolver. It does not deploy the full private endpoint policy set for every supported Azure service.

Microsoft references: [Network topology and connectivity](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) and [Private Link and DNS integration at scale](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale).
