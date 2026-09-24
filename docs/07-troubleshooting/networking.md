# Networking Troubleshooting

## No internet access

1. Check effective routes on the workload NIC.
2. Confirm the default route points to the intended next hop.
3. Check NSG rules.
4. Check Firewall policy and network/application rules.
5. Check DNS resolution.
6. Confirm the return path.

## Peering not connected

Check both peering objects, VNet IDs, permissions, address overlap, and whether the remote VNet was replaced.

## Private endpoint resolves publicly

Check the private DNS zone, record, VNet link, DNS server configuration, forwarding path, and the client resolver cache.

## Hybrid name resolution fails

Trace the full query path. Confirm the authoritative server, conditional forwarder domain, trailing dot, target IP, UDP/TCP 53 reachability, and return routing.

