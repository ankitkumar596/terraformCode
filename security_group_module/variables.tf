# security_group_module/variables.tf

variable "vpc_id" {
  description = "ID of the VPC to associate the security group with."
  type = string
}
