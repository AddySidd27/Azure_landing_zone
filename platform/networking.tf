resource "azurerm_resource_group" "connectivity" {
  name     = local.names.connectivity_rg
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "hub" {
  name                = local.names.hub_vnet
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  address_space       = var.hub_address_space
  tags                = local.common_tags
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet_prefix]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.bastion_subnet_prefix]
}

resource "azurerm_subnet" "dns_inbound" {
  name                 = "snet-dns-inbound"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.dns_inbound_subnet_prefix]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      name    = "Microsoft.Network/dnsResolvers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "dns_outbound" {
  name                 = "snet-dns-outbound"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.dns_outbound_subnet_prefix]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      name    = "Microsoft.Network/dnsResolvers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "private_endpoints" {
  name                              = "snet-private-endpoints"
  resource_group_name               = azurerm_resource_group.connectivity.name
  virtual_network_name              = azurerm_virtual_network.hub.name
  address_prefixes                  = [var.private_endpoint_subnet_prefix]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_virtual_network" "spoke" {
  name                = local.names.spoke_vnet
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  address_space       = var.spoke_address_space
  tags                = local.common_tags
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = azurerm_resource_group.connectivity.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.workload_subnet_prefix]
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-workload"
  resource_group_name       = azurerm_resource_group.connectivity.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-workload-to-hub"
  resource_group_name       = azurerm_resource_group.connectivity.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
}

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-${var.name_prefix}-workload-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  tags                = local.common_tags
}

resource "azurerm_subnet_network_security_group_association" "workload" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

resource "azurerm_route_table" "workload" {
  name                          = "rt-${var.name_prefix}-workload-${var.environment}"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.connectivity.name
  bgp_route_propagation_enabled = true
  tags                          = local.common_tags

  dynamic "route" {
    for_each = var.enable_firewall ? [1] : []
    content {
      name                   = "default-via-firewall"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = azurerm_firewall.platform[0].ip_configuration[0].private_ip_address
    }
  }
}

resource "azurerm_subnet_route_table_association" "workload" {
  subnet_id      = azurerm_subnet.workload.id
  route_table_id = azurerm_route_table.workload.id
}

