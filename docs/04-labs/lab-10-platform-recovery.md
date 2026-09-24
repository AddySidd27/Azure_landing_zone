# Lab 10: Platform Recovery Tabletop

## Scenario

The primary platform deployment runner is unavailable and a network change must be restored.

## Exercise

1. Identify the authoritative repository and tested commit.
2. Confirm remote state and version history are accessible.
3. Confirm an approved recovery identity can authenticate.
4. Reinitialize Terraform from a clean workstation or runner.
5. Generate a plan and compare it with the expected platform state.
6. Identify Firewall, routing, DNS, and monitoring dependencies.
7. Decide whether to roll forward, restore configuration, or recover state.
8. Record recovery time, blockers, decisions, and owners.

## Success criteria

- No state file is copied through email or chat.
- No engineer bypasses review with broad permanent access.
- The team can identify the last trusted code and state versions.
- The recovery process includes Azure validation, not only Terraform output.

