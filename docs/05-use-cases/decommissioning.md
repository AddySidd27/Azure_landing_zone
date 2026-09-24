# Use Case: Subscription Decommissioning

## Entry criteria

- Business owner approves retirement.
- Workload dependencies are identified.
- Data-retention and legal requirements are confirmed.
- Recovery period is agreed.

## Process

1. Block new workload deployment.
2. Capture resource, owner, cost, access, and dependency inventory.
3. Export required logs and data.
4. Remove traffic and DNS dependencies safely.
5. Revoke workload access and automation.
6. Delete or retain resources according to the approved schedule.
7. Move the subscription to Decommissioned.
8. Monitor for unexpected dependencies during the holding period.
9. Cancel the subscription only after final approval.
10. Update CMDB, IPAM, cost, security, and platform records.

Do not cancel a subscription as the first decommissioning action.

