#  create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-vpc"
  }
}
# create public subnets
resource "aws_subnet" "public_subnets" {
  count         =  length(var.public_subnets)
  vpc_id        =  aws_vpc.vpc.id
  cidr_block    =  var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.env}-public-subnet-${count.index+1}"
  }
}