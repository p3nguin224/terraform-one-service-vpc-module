module "web-app-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name   = "${var.instance_name}-SG"
  vpc_id = module.custom-vpc.vpc_id

  egress_rules  = var.webapp_outbound_rules
  ingress_rules = var.webapp_inbound_rules

  tags = var.tags
}
