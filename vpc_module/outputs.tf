output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.dev_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.dev_public_sub.id
}

output "private_subnet_id" {
  value = aws_subnet.dev_private_sub.id
}
