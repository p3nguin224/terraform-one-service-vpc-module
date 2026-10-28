locals {
  is_userdataExist = fileexists("${path.root}/${var.userdata_filename}")
}

module "web-app-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"

  ami                   = data.aws_ami.amazon_linux.id
  create_security_group = false
  name                  = var.instance_name
  instance_tags         = var.tags

  instance_type = var.instance_type
  key_name      = aws_key_pair.aws_keypair.key_name

  subnet_id              = module.custom-vpc.private_subnets[0]
  user_data_base64       = local.is_userdataExist ? filebase64("${path.root}/${var.userdata_filename}") : null
  create                 = local.is_userdataExist
  vpc_security_group_ids = [module.web-app-security-group.id]
}


module "bastion-ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.1"
  create  = var.use_Bastion

  ami                   = data.aws_ami.amazon_linux.id
  create_security_group = false
  name                  = "${module.custom-vpc.name}-bastion"
  instance_tags         = var.tags

  instance_type = var.instance_type
  key_name      = aws_key_pair.aws_keypair.key_name

  subnet_id = module.custom-vpc.public_subnets[0]

  vpc_security_group_ids = [module.web-app-security-group.id]
}

