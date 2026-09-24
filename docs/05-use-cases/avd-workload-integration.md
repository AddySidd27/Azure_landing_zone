# Use Case: Azure Virtual Desktop Workload Integration

AVD consumes the landing-zone foundation but remains a workload.

## Platform provides

- Governed AVD subscriptions
- Management-group policy inheritance
- Entra identity and privileged-access standards
- Hub connectivity and DNS
- Internet egress and security inspection when required
- Central monitoring and security integration
- Cost and tagging standards

## AVD workload provides

- Host pools and application groups
- Session hosts
- Image management
- FSLogix storage
- User assignment
- Autoscale
- Intune or other session-host management
- Workload-specific monitoring
- AVD recovery and capacity design

## Example subscription pattern

- AVD non-production subscription
- AVD production subscription
- Optional additional production subscriptions for scale, business boundaries, or regional architecture

Do not place session hosts or FSLogix shares in the connectivity subscription. Shared platform networking and workload resources need separate ownership and lifecycle.
