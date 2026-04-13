terraform {
  required_version = "~>1.14.0"
  cloud {
    organization = "emulsys"

    workspaces {
      name = "emulsys-debrin-local"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

provider "github" {
  owner = "debrin-og"
  token = var.pat_token
}