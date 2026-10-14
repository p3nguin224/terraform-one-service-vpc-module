resource "aws_key_pair" "aws_keypair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.privKey_for_keypair.public_key_openssh
}

resource "tls_private_key" "privKey_for_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "dev-key" {
  content         = tls_private_key.privKey_for_keypair.private_key_openssh
  filename        = "${path.root}/keys/${aws_key_pair.aws_keypair.key_name}"
  file_permission = "0400"
}

