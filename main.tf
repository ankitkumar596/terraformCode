provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
}


resource "aws_key_pair" "public_key" {
  key_name   = "public_key"
  public_key = file("./id_rsa.pub") # Update the path to your public key
}

resource "aws_key_pair" "public_key_us_east_2" {
  key_name   = "unique_key_pair_name_us_east_2"  # Choose a unique name
  public_key = file("./id_rsa.pub")
  provider   = aws.us-east-2
}


module "my_vpc" {
  source              = "./vpc_module"
  region              = "us-east-1"
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "dev_vpc"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

module "my_vpc_us_east_2" {
  source              = "./vpc_module"
  region              = "us-east-2"
  vpc_cidr            = "10.1.0.0/16"   # Example different CIDR block
  vpc_name            = "dev_vpc_us_east_2"
  public_subnet_cidr  = "10.1.1.0/24"   # Example different CIDR block
  private_subnet_cidr = "10.1.2.0/24"   # Example different CIDR block
  availability_zone   = "us-east-2a"    # Example different AZ
}


module "ec2_security_group" {
  source = "./security_group_module"
  vpc_id = module.my_vpc.vpc_id
}

module "my_ec2" {
  source = "./ec2_module"
  region                      = "us-east-1"
  ami                         = "ami-079db87dc4c10ac91"
  instance_type               = "t2.micro"
  subnet_id                   = module.my_vpc.public_subnet_id # Use the subnet ID from the VPC module
  key_name                    = aws_key_pair.public_key.key_name
  instance_name               = "my-ec2-instance"
  associate_public_ip_address = "true"

}

module "my_ec2_us_east_2" {
  source                      = "./ec2_module"
  region                      = "us-east-2"
  ami                         = "ami-033fabdd332044f06"  # Specify the correct AMI for us-east-2
  instance_type               = "t2.micro"  # Example instance type
  subnet_id                   = module.my_vpc_us_east_2.public_subnet_id
  key_name                    = aws_key_pair.public_key_us_east_2.key_name
  instance_name               = "my-ec2-instance-us-east-2"
  associate_public_ip_address = "true"
}
