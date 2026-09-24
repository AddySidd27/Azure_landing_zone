locals {
  names = {
    connectivity_rg = "rg-${var.name_prefix}-connectivity-${var.environment}-${var.location}"
    management_rg   = "rg-${var.name_prefix}-management-${var.environment}-${var.location}"
    security_rg     = "rg-${var.name_prefix}-security-${var.environment}-${var.location}"
    hub_vnet        = "vnet-${var.name_prefix}-hub-${var.environment}-${var.location}"
    spoke_vnet      = "vnet-${var.name_prefix}-workload-${var.environment}-${var.location}"
  }

  common_tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
    platform    = "azure-landing-zone"
  })

  management_group_ids = {
    identity       = try(azurerm_management_group.identity[0].id, null)
    management     = try(azurerm_management_group.management[0].id, null)
    connectivity   = try(azurerm_management_group.connectivity[0].id, null)
    security       = try(azurerm_management_group.security[0].id, null)
    corp           = try(azurerm_management_group.corp[0].id, null)
    online         = try(azurerm_management_group.online[0].id, null)
    local          = try(azurerm_management_group.local[0].id, null)
    sandbox        = try(azurerm_management_group.sandbox[0].id, null)
    decommissioned = try(azurerm_management_group.decommissioned[0].id, null)
  }
}

