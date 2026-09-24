data "azurerm_policy_definition" "allowed_locations" {
  count        = var.deploy_subscription_policy ? 1 : 0
  display_name = "Allowed locations"
}

resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  count                = var.deploy_subscription_policy ? 1 : 0
  name                 = "allowed-locations-audit"
  display_name         = "Audit resources outside approved locations"
  subscription_id      = "/subscriptions/${var.subscription_id}"
  policy_definition_id = data.azurerm_policy_definition.allowed_locations[0].id
  enforce              = false

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })

  non_compliance_message {
    content = "Use an approved Azure region or request a documented policy exemption."
  }
}

