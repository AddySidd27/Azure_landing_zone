# Lab 04: Policy Rollout

## Goal

Test an allowed-locations policy in audit mode before considering enforcement.

## Steps

1. Confirm the allowed locations.
2. Enable subscription policy deployment.
3. Review the plan and confirm `enforce = false`.
4. Apply the assignment.
5. Create or identify a test resource outside the approved list.
6. Wait for policy evaluation or trigger a scan.
7. Review compliance reason and assignment scope.
8. Document whether remediation, exemption, or enforcement is appropriate.

## Success evidence

- Assignment uses the intended built-in definition.
- Parameters contain only approved locations.
- Non-compliance is visible.
- No deny effect was introduced without impact review.

