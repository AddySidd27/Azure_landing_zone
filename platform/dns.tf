resource "azurerm_private_dns_resolver" "platform" {
  count               = var.enable_dns_private_resolver ? 1 : 0
  name                = "dnspr-${var.name_prefix}-${var.environment}"
  resource_group_name = azurerm_resource_group.connectivity.name
  location            = var.location
  virtual_network_id  = azurerm_virtual_network.hub.id
  tags                = local.common_tags
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "platform" {
  count                   = var.enable_dns_private_resolver ? 1 : 0
  name                    = "inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.platform[0].id
  location                = var.location
  tags                    = local.common_tags

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = azurerm_subnet.dns_inbound.id
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "platform" {
  count                   = var.enable_dns_private_resolver ? 1 : 0
  name                    = "outbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.platform[0].id
  location                = var.location
  subnet_id               = azurerm_subnet.dns_outbound.id
  tags                    = local.common_tags
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "platform" {
  count                                      = var.enable_dns_private_resolver && length(var.dns_forwarding_rules) > 0 ? 1 : 0
  name                                       = "dnsfrs-${var.name_prefix}-${var.environment}"
  resource_group_name                        = azurerm_resource_group.connectivity.name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.platform[0].id]
  tags                                       = local.common_tags
}

resource "azurerm_private_dns_resolver_forwarding_rule" "rules" {
  for_each = var.enable_dns_private_resolver ? var.dns_forwarding_rules : {}

  name                      = each.key
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.platform[0].id
  domain_name               = each.value.domain_name
  enabled                   = true

  dynamic "target_dns_servers" {
    for_each = each.value.target_ips
    content {
      ip_address = target_dns_servers.value
      port       = 53
    }
  }
}

resource "azurerm_private_dns_resolver_virtual_network_link" "spoke" {
  count                     = var.enable_dns_private_resolver && length(var.dns_forwarding_rules) > 0 ? 1 : 0
  name                      = "link-workload-spoke"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.platform[0].id
  virtual_network_id        = azurerm_virtual_network.spoke.id
  metadata                  = local.common_tags
}

