variable "subscription_id" { type = string }
variable "tenant_id" { type = string }
variable "location" { type = string }
variable "environment" { type = string }
variable "name_prefix" { type = string }
variable "management_group_prefix" { type = string }
variable "deploy_management_groups" { type = bool }
variable "subscription_placements" {
  description = "Map of subscription ID to management-group key: identity, management, connectivity, security, corp, online, local, sandbox, or decommissioned."
  type        = map(string)
  default     = {}
}
variable "deploy_subscription_policy" { type = bool }
variable "allowed_locations" { type = list(string) }
variable "hub_address_space" { type = list(string) }
variable "spoke_address_space" { type = list(string) }
variable "firewall_subnet_prefix" { type = string }
variable "bastion_subnet_prefix" { type = string }
variable "dns_inbound_subnet_prefix" { type = string }
variable "dns_outbound_subnet_prefix" { type = string }
variable "private_endpoint_subnet_prefix" { type = string }
variable "workload_subnet_prefix" { type = string }
variable "enable_firewall" { type = bool }
variable "enable_bastion" { type = bool }
variable "enable_dns_private_resolver" { type = bool }
variable "dns_forwarding_rules" {
  type = map(object({
    domain_name = string
    target_ips  = list(string)
  }))
  default = {}
}
variable "enable_key_vault" { type = bool }
variable "defender_plans" {
  description = "Defender for Cloud resource types to enable at Standard tier. Empty by default because paid plans require security and cost approval."
  type        = set(string)
  default     = []
  validation {
    condition = alltrue([
      for plan in var.defender_plans : contains([
        "AI",
        "Api",
        "AppServices",
        "Arm",
        "CloudPosture",
        "ContainerRegistry",
        "Containers",
        "CosmosDbs",
        "Dns",
        "KeyVaults",
        "KubernetesService",
        "OpenSourceRelationalDatabases",
        "SqlServers",
        "SqlServerVirtualMachines",
        "StorageAccounts",
        "VirtualMachines"
      ], plan)
    ])
    error_message = "defender_plans contains an unsupported AzureRM 5.4.0 resource type."
  }
}
variable "enable_activity_log_diagnostics" { type = bool }
variable "log_retention_days" { type = number }
variable "monthly_budget_amount" { type = number }
variable "budget_contact_emails" { type = list(string) }
variable "tags" { type = map(string) }
