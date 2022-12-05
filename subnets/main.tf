module "lm-subnets" {
  for_each   = var.subnets
  cidr_block = each.value.cidr_block
  source     = "./lm-subnets"
  vpc_id     = var.vpc_id[0]
  env        = var.env
  name       = each.value.name
  subnet_availability_zones = var.subnet_availability_zones
#  route_table_id  = lookup(aws_route_table.route-table,each.value.name, null)
}

resource "aws_route_table" "route-table" {
  for_each   = var.subnets
  vpc_id     = var.vpc_id[0]
  tags       = {
      Name    = "${var.env}-${each.value.name}-rt"
      ENV     = var.env
      PROJECT = "roboshop"
    }
  }

#output "subnets" {
#  value = module.lm-subnets
#}

output "route-tables" {
  value = "aws_route_table.aws_route_table"
}