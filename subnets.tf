module "public_subnets" {
  for_each                  = var.vpc
  source                    = "./subnets"
  subnets                   = each.value.public_subnets
  vpc_id                    = [ for k, v in aws_vpc.main : v.id ]
  env                       = var.env
  subnet_availability_zones = each.value.subnet_availability_zones
  peering_connection_id     = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
  management_vpc            = var.management_vpc
  internet_gateway_id       = aws_internet_gateway.gw.*.id[0]
}

module "private_subnets" {
  for_each                  = var.vpc
  source                    = "./subnets"
  subnets                   = each.value.private_subnets
  vpc_id                    = [for k, v in aws_vpc.main : v.id]
  env                       = var.env
  subnet_availability_zones = each.value.subnet_availability_zones
  peering_connection_id     = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
  management_vpc            = var.management_vpc
  internet_gateway_id       = aws_internet_gateway.gw.*.id[0]
}

output "public_subnets" {
  value = module.public_subnets
}

output "private_subnets" {
    value = module.private_subnets
}

output "all_private_subnets" {
  value = [for k,v in module.private_subnets : k ]
}
