variable "subscription_id" {
  description = "Subscription used to store Terraform state."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "subscription_id must be a valid Azure subscription GUID."
  }
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.tenant_id))
    error_message = "tenant_id must be a valid Microsoft Entra tenant GUID."
  }
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "name_prefix" {
  type    = string
  default = "alzlab"
  validation {
    condition     = can(regex("^[a-z0-9]{3,12}$", var.name_prefix))
    error_message = "name_prefix must contain 3-12 lowercase letters or numbers."
  }
}

variable "tags" {
  type = map(string)
  default = {
    managed_by = "terraform"
    purpose    = "landing-zone-state"
  }
}

