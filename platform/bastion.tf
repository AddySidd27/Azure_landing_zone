resource "azurerm_public_ip" "bastion" {
  count               = var.enable_bastion ? 1 : 0
  name                = "pip-${var.name_prefix}-bastion-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_bastion_host" "platform" {
  count               = var.enable_bastion ? 1 : 0
  name                = "bas-${var.name_prefix}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.connectivity.name
  sku                 = "Basic"
  tags                = local.common_tags

  ip_configuration {
    name                 = "platform"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }
}

