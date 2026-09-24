resource "azurerm_management_group" "root" {
  count        = var.deploy_management_groups ? 1 : 0
  name         = var.management_group_prefix
  display_name = "Enterprise Landing Zone"
}

resource "azurerm_management_group" "platform" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-platform"
  display_name               = "Platform"
  parent_management_group_id = azurerm_management_group.root[0].id
}

resource "azurerm_management_group" "identity" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-identity"
  display_name               = "Identity"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "management" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-management"
  display_name               = "Management"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "connectivity" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-connectivity"
  display_name               = "Connectivity"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "security" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-security"
  display_name               = "Security"
  parent_management_group_id = azurerm_management_group.platform[0].id
}

resource "azurerm_management_group" "landing_zones" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-landingzones"
  display_name               = "Landing Zones"
  parent_management_group_id = azurerm_management_group.root[0].id
}

resource "azurerm_management_group" "corp" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-corp"
  display_name               = "Corp"
  parent_management_group_id = azurerm_management_group.landing_zones[0].id
}

resource "azurerm_management_group" "online" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-online"
  display_name               = "Online"
  parent_management_group_id = azurerm_management_group.landing_zones[0].id
}

resource "azurerm_management_group" "local" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-local"
  display_name               = "Local"
  parent_management_group_id = azurerm_management_group.landing_zones[0].id
}

resource "azurerm_management_group" "sandbox" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-sandbox"
  display_name               = "Sandbox"
  parent_management_group_id = azurerm_management_group.root[0].id
}

resource "azurerm_management_group" "decommissioned" {
  count                      = var.deploy_management_groups ? 1 : 0
  name                       = "${var.management_group_prefix}-decommissioned"
  display_name               = "Decommissioned"
  parent_management_group_id = azurerm_management_group.root[0].id
}

resource "azurerm_management_group_subscription_association" "placement" {
  for_each = var.deploy_management_groups ? var.subscription_placements : {}

  management_group_id = local.management_group_ids[each.value]
  subscription_id     = "/subscriptions/${each.key}"
}

