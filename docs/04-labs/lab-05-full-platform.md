# Lab 05: Full Platform Services

## Goal

Add shared network and security services after cost and architecture review.

## Added capabilities

- Azure Firewall and baseline policy
- Default spoke route through the firewall
- Azure Bastion
- Azure DNS Private Resolver
- Optional forwarding rules with real DNS targets
- Key Vault with public access disabled
- Key Vault private endpoint and private DNS

## Validation order

1. Confirm cost approval.
2. Confirm subnet sizes and address overlap.
3. Confirm firewall application rules meet the lab requirement.
4. Confirm the spoke default route points to the firewall private IP.
5. Confirm Bastion has no dependency on a workload public IP.
6. Confirm DNS forwarding domains end with a trailing dot and target approved DNS servers.
7. Resolve the Key Vault name from the spoke path and confirm the private IP result.
8. Review logs and cleanup timing.

The example firewall rules are not a production allowlist. A production ruleset must come from documented application and platform requirements.

