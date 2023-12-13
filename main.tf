terraform {
    required_version = "1.6.6"
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.6.0"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.0.0"
    }
  }
}

provider "sops" {}

data "sops_file" "fake-secret" {
  source_file = "fake-secret.enc.json"
}

resource "random_pet" "pet" {
  keepers = {
    secret = data.sops_file.fake-secret.data["secret"]
  }
  length = 1
}

output "fake-secret" {
  value = data.sops_file.fake-secret.data["secret"]
  description = "Fake secret content"
  sensitive = true
}
