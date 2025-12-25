locals {
  business_divsion = var.business_divsion
  environment      = var.environment
  prefix           = "${var.business_divsion}-${var.environment}"
  common_tags = {
    owner       = local.business_divsion,
    environment = local.environment,
    created-by  = "packer",
    "os"        = "ubuntu"
  }
} 