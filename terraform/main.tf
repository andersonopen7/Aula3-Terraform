terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_41e99fee520786cf7b2cedd62d5a8b2c473cb87c9f2176361ae5816b900ca637"
}

resource "digitalocean_droplet" "jenkins" {
  image    = "ubuntu-22-04-x64"
  name     = "jenkins"
  region   = "nyc1"
  size     = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.DevOps.id]
}

data "digitalocean_ssh_key" "DevOps" {
  name = "DevOps"
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name    = "k8s"
  region  = "nyc1"
  version = "1.25.4-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}
