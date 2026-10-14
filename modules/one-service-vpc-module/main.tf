module "custom-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  name = var.vpc_name
  azs  = data.aws_availability_zones.available_az.names
  cidr = var.vpc_cidr

  create_igw                       = true
  create_private_nat_gateway_route = true

  # Enable NAT Gateways
  enable_nat_gateway = true
  single_nat_gateway = true

  manage_default_route_table = false

  nat_gateway_tags = {
    "Name" : "terraform_nat_GW"
  }

  private_route_table_tags = {
    "Name" : "terraform_private_route_table"
  }

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = var.tags

}
