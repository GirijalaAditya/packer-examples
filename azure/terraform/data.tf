data "azurerm_resource_group" "rg" {
  name = var.azure_resource_group_name
}

data "azurerm_image" "image" {
 resource_group_name = data.azurerm_resource_group.rg.name
  name_regex                = "itops-dev-azure-*"
  sort_descending = true
}

