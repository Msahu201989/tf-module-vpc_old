module "lm-subnets" {
  for_each   = var.subnets
  cidr_block = each.value.cidr_block
  source     = "./lm-subnets"
  vpc_id     = var.vpc_id[0]
  env        = var.env
  name       = each.value.name
  subnet_availability_zones = var.subnet_availability_zones
  route_table_id  = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
}

resource "aws_route_table" "aws_route_table" {
  for_each   = var.subnets
  vpc_id     = var.vpc_id[0]
  tags       = {
      Name    = "${var.env}-${each.value.name}-rt"
      ENV     = var.env
      PROJECT = "roboshop"
    }
  }

resource "aws_route" "peering_connection_route" {
  for_each                  = var.subnets
  route_table_id            = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
  destination_cidr_block    = lookup(var.management_vpc, "vpc_cidr", null)
  vpc_peering_connection_id = var.peering_connection_id
}


#resource "aws_route" "gateway_connection_route" {
#  for_each                  = var.subnets
#  route_table_id            = lookup(lookup(aws_route_table.aws_route_table, each.value.name, null), "id", null)
#  destination_cidr_block    = lookup(var.management_vpc, "vpc_cidr", null)
#  vpc_peering_connection_id = var.peering_connection_id
#}

output "subnets" {
  value = [ for i, j in module.lm-subnets: j ]
}

#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo ${module.lm-subnets}"
#  }
#}