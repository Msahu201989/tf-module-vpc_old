module "private_subnets" {
  for_each                  = var.private_subnets
  source                    = "./subnets"
  cidr_block                = each.value.cidr_block
  vpc_id                    = aws_vpc.main.id
  env                       = var.env
  name                      = each.value.name
  subnet_availability_zones = var.subnet_availability_zones
#  peering_connection_id     = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
#  management_vpc            = var.management_vpc
    gateway_id                = aws_nat_gateway.ngw.id
}

module "public_subnets" {
  for_each                  = var.public_subnets
  source                    = "./subnets"
  cidr_block                = each.value.cidr_block
  vpc_id                    = aws_vpc.main.id
  env                       = var.env
  name                      = each.value.name
  subnet_availability_zones = var.subnet_availability_zones
  #  peering_connection_id     = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
  #  management_vpc            = var.management_vpc
  gateway_id                = aws_internet_gateway.igw.*.id
}
