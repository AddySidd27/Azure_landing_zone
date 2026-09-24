output "resource_groups" {
  value = {
    connectivity = azurerm_resource_group.connectivity.name
    management   = azurerm_resource_group.management.name
    security     = try(azurerm_resource_group.security[0].name, null)
  }
}

output "networking" {
  value = {
    hub_vnet_id        = azurerm_virtual_network.hub.id
    spoke_vnet_id      = azurerm_virtual_network.spoke.id
    workload_subnet_id = azurerm_subnet.workload.id
    firewall_private_ip = try(
      azurerm_firewall.platform[0].ip_configuration[0].private_ip_address,
      null
    )
  }
}

output "management" {
  value = {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.platform.id
    action_group_id            = azurerm_monitor_action_group.platform.id
  }
}

output "enabled_features" {
  value = {
    management_groups    = var.deploy_management_groups
    subscription_policy  = var.deploy_subscription_policy
    firewall             = var.enable_firewall
    bastion              = var.enable_bastion
    dns_private_resolver = var.enable_dns_private_resolver
    key_vault            = var.enable_key_vault
    defender_plans       = sort(tolist(var.defender_plans))
  }
}
