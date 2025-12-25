packer {
  required_plugins {
    amazon = {
      version = "~> 1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name        = "${local.prefix}-{{timestamp}}"
  ami_description = "packer-ubuntu-aws-{{timestamp}}"
  instance_type   = var.instance_type
  region          = var.region

  // Mutliple regions
  // ami_regions   = ["us-west-2", "us-east-1"]

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }

  ssh_username = "ubuntu"
  tags         = local.common_tags
}

build {
  name = "packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "echo === OSPatching ===",
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install -y nginx"
    ]
  }

  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }

  post-processor "manifest" {}
}