resource "random_string" "key_vault_suffix" {
  count   = var.enable_key_vault ? 1 : 0
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "security" {
  count    = var.enable_key_vault ? 1 : 0
  name     = local.names.security_rg
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_key_vault" "platform" {
  count                         = var.enable_key_vault ? 1 : 0
  name                          = "kv-${var.name_prefix}-${random_string.key_vault_suffix[0].result}"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.security[0].name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 90
  public_network_access_enabled = false
  tags                          = local.common_tags
}

resource "azurerm_private_dns_zone" "key_vault" {
  count               = var.enable_key_vault ? 1 : 0
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.security[0].name
  tags                = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault_hub" {
  count               = var.enable_key_vault ? 1 : 0
  name                = "link-hub"
  private_dns_zone_id = azurerm_private_dns_zone.key_vault[0].id
  virtual_network_id  = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "key_vault_spoke" {
  count               = var.enable_key_vault ? 1 : 0
  name                = "link-workload"
  private_dns_zone_id = azurerm_private_dns_zone.key_vault[0].id
  virtual_network_id  = azurerm_virtual_network.spoke.id
}

resource "azurerm_private_endpoint" "key_vault" {
  count               = var.enable_key_vault ? 1 : 0
  name                = "pe-${var.name_prefix}-keyvault-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.security[0].name
  subnet_id           = azurerm_subnet.private_endpoints.id
  tags                = local.common_tags

  private_service_connection {
    name                           = "psc-keyvault"
    private_connection_resource_id = azurerm_key_vault.platform[0].id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.key_vault[0].id]
  }
}

resource "azurerm_security_center_subscription_pricing" "defender" {
  for_each = var.defender_plans

  tier          = "Standard"
  resource_type = each.value
}
