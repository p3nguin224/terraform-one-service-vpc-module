module "web-app-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name   = "${var.instance_name}-SG"
  vpc_id = module.custom-vpc.vpc_id

  egress_rules = var.webapp_outbound_rules

  # add ssh inbound from bastion host if Bastion is created
  ingress_rules = var.use_Bastion ? merge(var.webapp_inbound_rules,
    {
      bastion-ssh = {
        from_port                    = 22
        ip_protocol                  = "tcp"
        referenced_security_group_id = module.bastion-security-group.id
        description                  = "SSH access from bastion host"
      }
  }) : var.webapp_inbound_rules

  tags = var.tags
}

module "bastion-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  create = var.use_Bastion
  name   = "bastion-host-SG"
  vpc_id = module.custom-vpc.vpc_id

  egress_rules  = var.bastion_outbound_rules
  ingress_rules = var.bastion_inbound_rules
  tags          = var.tags
}
