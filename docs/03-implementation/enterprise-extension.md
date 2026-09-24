# Enterprise Extension

The core code is deliberately readable. A production platform normally adds stronger subscription and delivery separation.

## Recommended extension path

1. Evaluate the Azure Landing Zones IaC Accelerator.
2. Use Azure Verified Modules for supported platform patterns.
3. Split connectivity, management, security, and workload deployment into controlled stacks or provider aliases.
4. Use a federated CI identity with separate plan and apply permissions.
5. Add policy initiatives, remediation identities, exemptions, and compliance evidence.
6. Add Defender for Cloud plans only after coverage, ownership, and cost decisions.
7. Add diagnostic settings at scale through policy.
8. Integrate SIEM, ITSM, CMDB, IP address management, and subscription vending where required.
9. Add non-production platform validation before production rollout.
10. Test recovery, provider upgrades, policy changes, and decommissioning.

## Why this is not hidden in the lab

A single-subscription example cannot honestly prove enterprise separation of duties or cross-subscription operations. The repository shows the boundary and gives a safe learning path instead of presenting one subscription as a full enterprise landing zone.

Microsoft reference: [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options)

