variable "client_id" {
  type        = string
  description = "Azure Client ID"
  default     = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  default     = "${env("ARM_CLIENT_SECRET")}"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
  default     = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
  default     = "${env("ARM_TENANT_ID")}"
}

variable "azure_resource_group_name" {
  type        = string
  description = "Azure Resource Group Name"
}

variable "business_divsion" {
  description = "Business Division"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "cloud" {
  description = "Cloud Platform"
  type        = string
}