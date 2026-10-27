output "web-app-ec2-arn" {
  value = module.web-app-ec2.arn
}

output "web-app-sg" {
  value = {
    arn            = module.web-app-security-group.arn
    id             = module.web-app-security-group.id
    name           = module.web-app-security-group.name
    inbound_rules  = var.webapp_inbound_rules
    outbound_rules = var.webapp_outbound_rules
  }
}


output "bastion-sg" {
  value = try({
    arn            = module.web-app-security-group.arn
    id             = module.web-app-security-group.id
    name           = module.web-app-security-group.name
    inbound_rules  = var.webapp_inbound_rules
    outbound_rules = var.webapp_outbound_rules
  }, null)
}

output "web-app-instance" {
  value = try({
    arn            = module.web-app-ec2.arn
    id             = module.web-app-ec2.id
    private_ip     = module.web-app-ec2.private_ip
    public_ip      = module.web-app-ec2.public_ip
    instance_state = module.web-app-ec2.instance_state
  }, null)
}

output "bastion-instance" {
  value = try({
    arn            = module.bastion-ec2.arn
    id             = module.bastion-ec2.id
    private_ip     = module.bastion-ec2.private_ip
    public_ip      = module.bastion-ec2.public_ip
    instance_state = module.bastion-ec2.instance_state
  }, null)
}


