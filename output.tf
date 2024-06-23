
# Access outputs from the module if needed
output "my_vpc_id" {
  value = module.my_vpc.vpc_id
}

output "my_public_subnet_id" {
  value = module.my_vpc.public_subnet_id
}

output "my_private_subnet_id" {
  value = module.my_vpc.private_subnet_id
}

# Access outputs from the EC2 module if needed
output "my_ec2_instance_id" {
  value = module.my_ec2.instance_id
}

output "my_ec2_public_ip" {
  value = module.my_ec2.public_ip
}

output "my_ec2_security_group" {
  value = module.ec2_security_group.ec2_security_group_id
}
