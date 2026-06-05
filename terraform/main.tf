terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"
    }
  }
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key to inject into the instance"
  default     = "~/.ssh/id_ed25519.pub"
}

provider "scaleway" {
  zone   = "fr-par-1"
  region = "fr-par"
}

resource "scaleway_iam_ssh_key" "demo" {
  name       = "demo-workshop-key"
  public_key = file(var.ssh_public_key_path)
}

resource "scaleway_instance_ip" "public_ip" {
  type = "routed_ipv4"
}

resource "scaleway_instance_server" "demo" {
  type  = "DEV1-S"
  image = "ubuntu_jammy"
  name  = "demo-rails-app"

  ip_id = scaleway_instance_ip.public_ip.id

  tags = ["demo", "rails", "workshop"]
}

output "server_ip" {
  description = "Public IP address of the demo instance"
  value       = scaleway_instance_ip.public_ip.address
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh root@${scaleway_instance_ip.public_ip.address}"
}
