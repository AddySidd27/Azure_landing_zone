mock_provider "azurerm" {}
mock_provider "random" {}

run "full_platform_plan" {
  command = plan

  variables {
    subscription_id                 = "00000000-0000-0000-0000-000000000001"
    tenant_id                       = "00000000-0000-0000-0000-000000000002"
    location                        = "eastus2"
    environment                     = "platform"
    name_prefix                     = "contoso"
    management_group_prefix         = "contoso"
    deploy_management_groups        = true
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
    enable_firewall                 = true
    enable_bastion                  = true
    enable_dns_private_resolver     = true
    dns_forwarding_rules            = {}
    enable_key_vault                = true
    defender_plans                  = []
    enable_activity_log_diagnostics = true
    log_retention_days              = 90
    monthly_budget_amount           = 500
    budget_contact_emails           = []
    tags                            = { owner = "cloud-platform" }
  }

  assert {
    condition     = length(azurerm_firewall.platform) == 1
    error_message = "Full platform must deploy one Azure Firewall when enabled."
  }

  assert {
    condition     = length(azurerm_bastion_host.platform) == 1
    error_message = "Full platform must deploy one Azure Bastion when enabled."
  }

  assert {
    condition     = length(azurerm_private_dns_resolver.platform) == 1
    error_message = "Full platform must deploy one DNS Private Resolver when enabled."
  }

  assert {
    condition     = length(azurerm_key_vault.platform) == 1
    error_message = "Full platform must deploy one Key Vault when enabled."
  }
}

