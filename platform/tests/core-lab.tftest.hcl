mock_provider "azurerm" {}
mock_provider "random" {}

run "core_lab_plan" {
  command = plan

  variables {
    subscription_id                 = "00000000-0000-0000-0000-000000000001"
    tenant_id                       = "00000000-0000-0000-0000-000000000002"
    location                        = "eastus2"
    environment                     = "lab"
    name_prefix                     = "contoso"
    management_group_prefix         = "contoso"
    deploy_management_groups        = false
    subscription_placements         = {}
    deploy_subscription_policy      = false
    allowed_locations               = ["eastus2"]
    hub_address_space               = ["10.10.0.0/16"]
    spoke_address_space             = ["10.20.0.0/16"]
    firewall_subnet_prefix          = "10.10.0.0/26"
    bastion_subnet_prefix           = "10.10.0.64/26"
    dns_inbound_subnet_prefix       = "10.10.0.128/28"
    dns_outbound_subnet_prefix      = "10.10.0.144/28"
    private_endpoint_subnet_prefix  = "10.10.0.160/27"
    workload_subnet_prefix          = "10.20.1.0/24"
    enable_firewall                 = false
    enable_bastion                  = false
    enable_dns_private_resolver     = false
    dns_forwarding_rules            = {}
    enable_key_vault                = false
    defender_plans                  = []
    enable_activity_log_diagnostics = true
    log_retention_days              = 30
    monthly_budget_amount           = 75
    budget_contact_emails           = []
    tags                            = { owner = "platform-lab" }
  }

  assert {
    condition     = length(azurerm_firewall.platform) == 0
    error_message = "Core lab must not deploy Azure Firewall by default."
  }

  assert {
    condition     = length(azurerm_bastion_host.platform) == 0
    error_message = "Core lab must not deploy Azure Bastion by default."
  }

  assert {
    condition = (
      length(azurerm_virtual_network.hub.address_space) == 1 &&
      contains(azurerm_virtual_network.hub.address_space, "10.10.0.0/16")
    )
    error_message = "Core lab hub address space is incorrect."
  }
}
