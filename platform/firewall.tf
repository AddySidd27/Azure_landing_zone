resource "azurerm_public_ip" "firewall" {
  count               = var.enable_firewall ? 1 : 0
  name                = "pip-${var.name_prefix}-firewall-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_firewall_policy" "platform" {
  count               = var.enable_firewall ? 1 : 0
  name                = "afwp-${var.name_prefix}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  sku                 = "Standard"
  tags                = local.common_tags

  dns {
    proxy_enabled = var.enable_dns_private_resolver
  }
}

resource "azurerm_firewall" "platform" {
  count               = var.enable_firewall ? 1 : 0
  name                = "azfw-${var.name_prefix}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.platform[0].id
  tags                = local.common_tags

  ip_configuration {
    name                 = "platform"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall[0].id
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "baseline" {
  count              = var.enable_firewall ? 1 : 0
  name               = "baseline-egress"
  firewall_policy_id = azurerm_firewall_policy.platform[0].id
  priority           = 500

  application_rule_collection {
    name     = "allow-required-platform-services"
    priority = 500
    action   = "Allow"

    rule {
      name             = "allow-azure-management"
      source_addresses = var.spoke_address_space
      destination_fqdns = [
        "management.azure.com",
        "login.microsoftonline.com"
      ]
      protocols {
        type = "Https"
        port = 443
      }
    }
  }
}

