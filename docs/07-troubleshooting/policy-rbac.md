# Policy and RBAC Troubleshooting

## Deployment denied

Read the policy assignment ID in the error. Identify the inherited scope, definition, effect, parameters, and evaluated field. Decide whether the resource is wrong, the policy is wrong, or an approved exemption is required.

## Access denied

Identify the actual caller, required action, assigned role, assignment scope, deny assignments, PIM activation, and propagation delay. Distinguish control-plane permissions from data-plane permissions.

## Policy shows non-compliant after a fix

Confirm the resource property changed, trigger or wait for evaluation, inspect the compliance reason, and verify remediation identity permissions for Modify or DeployIfNotExists policies.

Do not grant Owner at subscription scope as the first troubleshooting step.

