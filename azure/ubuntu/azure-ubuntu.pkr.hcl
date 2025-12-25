packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}


source "azure-arm" "ubuntu" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  managed_image_name                = "${local.prefix}-${var.cloud}-{{timestamp}}"
  build_resource_group_name         = var.azure_resource_group_name
  managed_image_resource_group_name = var.azure_resource_group_name

  os_type         = "Linux"
  image_publisher = "canonical"
  image_offer     = "ubuntu-24_04-lts"
  image_sku       = "server"
  image_version   = "latest"

  azure_tags = local.common_tags

  vm_size       = "Standard_B1s"
  public_ip_sku = "Standard"
}

build {
  name = "packer"
  sources = [
    "source.azure-arm.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo === OSPatching ===",
      "sudo apt update -y",
      "sudo apt upgrade -y",
    ]
  }

  provisioner "file" {
    source      = "scripts/softwares.sh"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo sh /tmp/scripts/softwares.sh",
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }


  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
    custom_data = {
      source_image_name = "${build.SourceImageName}"
    }
  }
}