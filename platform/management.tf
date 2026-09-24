resource "azurerm_resource_group" "management" {
  name     = local.names.management_rg
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_log_analytics_workspace" "platform" {
  name                           = "law-${var.name_prefix}-${var.environment}-${var.location}"
  location                       = var.location
  resource_group_name            = azurerm_resource_group.management.name
  sku                            = "PerGB2018"
  retention_in_days              = var.log_retention_days
  internet_ingestion_access_type = "Enabled"
  internet_query_access_type     = "Enabled"
  tags                           = local.common_tags
}

resource "azurerm_monitor_action_group" "platform" {
  name                = "ag-${var.name_prefix}-${var.environment}"
  resource_group_name = azurerm_resource_group.management.name
  short_name          = "alz-${var.environment}"
  tags                = local.common_tags

  dynamic "email_receiver" {
    for_each = toset(var.budget_contact_emails)
    content {
      name                    = replace(email_receiver.value, "@", "-")
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "subscription_activity" {
  count                      = var.enable_activity_log_diagnostics ? 1 : 0
  name                       = "send-activity-log-to-platform-law"
  target_resource_id         = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.platform.id

  enabled_log { category = "Administrative" }
  enabled_log { category = "Security" }
  enabled_log { category = "ServiceHealth" }
  enabled_log { category = "Alert" }
  enabled_log { category = "Recommendation" }
  enabled_log { category = "Policy" }
  enabled_log { category = "Autoscale" }
  enabled_log { category = "ResourceHealth" }
}

resource "azurerm_consumption_budget_subscription" "platform" {
  name            = "budget-${var.name_prefix}-${var.environment}"
  subscription_id = "/subscriptions/${var.subscription_id}"
  amount          = var.monthly_budget_amount
  time_grain      = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00'Z'", timestamp())
  }

  notification {
    enabled        = length(var.budget_contact_emails) > 0
    threshold      = 80
    operator       = "GreaterThan"
    threshold_type = "Actual"
    contact_emails = var.budget_contact_emails
  }

  lifecycle {
    ignore_changes = [time_period]
  }
}
