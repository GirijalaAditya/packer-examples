data "azurerm_image" "search" {
  name_regex                = "itops-dev-azure-*"
  resource_group_name = "packer-rg"
  sort_descending = true
}

output "image_id" {
  value = data.azurerm_image.search.id
}


