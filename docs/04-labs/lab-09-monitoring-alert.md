# Lab 09: Monitoring and Alert Validation

## Goal

Prove that telemetry reaches the destination and an approved responder receives an alert.

## Procedure

1. Confirm subscription Activity Logs target Log Analytics.
2. Run a query for recent administrative events.
3. Create a low-risk test alert rule.
4. Add an approved test receiver to the Action Group.
5. Trigger the test condition.
6. Confirm the alert fired and the receiver was notified.
7. Record acknowledgement and response steps.
8. Remove temporary test resources.

## Evidence

- Log query and timestamp
- Diagnostic setting
- Alert rule condition
- Action Group result
- Response owner
- Cleanup result

Creating a workspace and Action Group is not sufficient. The complete signal-to-response path must be tested.

