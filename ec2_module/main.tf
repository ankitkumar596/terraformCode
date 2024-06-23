provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  # security_group_ids  = var.security_group_ids 
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = var.instance_name
  }

}
