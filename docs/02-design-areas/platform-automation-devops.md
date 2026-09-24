# Platform Automation and DevOps

Infrastructure as code gives the platform a reviewed, repeatable history.

## Delivery flow

```text
Issue -> Branch -> Format and validate -> Security checks -> Plan -> Review -> Approval -> Apply -> Verify
```

## Controls

- Store code in version control.
- Protect the main branch.
- Use pull-request review.
- Authenticate CI with workload identity federation.
- Keep secrets out of code and state inputs.
- Store remote state with controlled access and recovery features.
- Save plans only for the intended environment.
- Separate plan and apply permissions.
- Pin versions and review upgrades.
- Detect drift instead of accepting manual changes silently.

Microsoft recommends infrastructure as code and documents the Azure Landing Zones IaC Accelerator as a standard implementation path. This repository remains readable for learning and explains where a production team should use the accelerator or AVM modules.

Microsoft reference: [Platform landing zone implementation options](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/implementation-options)

