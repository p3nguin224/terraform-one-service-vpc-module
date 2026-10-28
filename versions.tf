terraform {
  required_version = "1.16.6"

  cloud {

    organization = "thawzin-tfc"

    workspaces {
      name = "vpc-module-with-peering"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.region
  #profile = var.profile
}
