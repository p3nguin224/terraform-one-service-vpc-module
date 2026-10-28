module "statement-app" {
  source = "./modules/one-service-vpc-module"

  target_region   = var.region
  vpc_name        = "Terraform-statement-vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.100.0/24", "10.0.200.0/24"]
  tags = {
    "Environment" = "dev"
    "createdBy"   = "Terraform"
  }

  instance_name     = "statement-app"
  key_pair_name     = "dev-key.pem"
  userdata_filename = "test-userdata.sh"
  webapp_inbound_rules = {
    web-access = {
      from_port   = 9093
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "HTTPS from internal"
    }
  }

  use_Bastion = true
  bastion_inbound_rules = {
    ssh-access = {
      from_port   = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "61.21.197.51/32"
      description = "ssh management"
    }
  }

}

