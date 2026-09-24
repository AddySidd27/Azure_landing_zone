# What Is an Azure Landing Zone?

An Azure landing zone is the prepared environment where cloud workloads can be deployed and operated safely.

It is not one resource, one subscription, or one Terraform module. It is a combination of:

- resource organization;
- identity and access controls;
- network connectivity;
- governance policies;
- security controls;
- monitoring and operations;
- automation and delivery processes.

## Platform boundary

The platform landing zone provides shared capabilities such as management groups, policy, connectivity, monitoring, and platform security.

A workload subscription contains resources owned by a workload team. It receives the platform guardrails but has a separate lifecycle from shared platform services.

```text
Platform team                 Workload team
-------------                 -------------
Management groups             Application resources
Policy baseline               Workload network and data
Shared connectivity           Workload monitoring
Central monitoring            Application lifecycle
Platform security             Business continuity
```

The platform team does not own every application resource. The workload team does not redesign the enterprise platform for each application.

## Why organizations use landing zones

Without a landing zone, each project can create its own identity, network, logging, security, and cost model. This causes inconsistent controls and expensive remediation later.

A landing zone gives teams a repeatable starting point. It speeds up delivery because important decisions and guardrails already exist.

Microsoft reference: [Azure landing zones](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/)
