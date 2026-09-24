# Built-in "Allowed locations" policy. The ID is stable across tenants,
# unlike a display-name lookup that can match a custom definition.
resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  count                = var.deploy_subscription_policy ? 1 : 0
  name                 = "allowed-locations-audit"
  display_name         = "Audit resources outside approved locations"
  subscription_id      = "/subscriptions/${var.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
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

