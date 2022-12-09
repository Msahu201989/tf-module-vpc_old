resource "aws_vpc_peering_connection" "management-vpc-to-env-vpc" {
  peer_vpc_id = aws_vpc.main.id
  vpc_id      = lookup(var.management_vpc, "vpc_id", null)
  auto_accept = true
  tags        = local.vpc_peering_tags
}

#
#resource "aws_route" "route_to_default_management_route_table" {
#  for_each                  = var.vpc
#  route_table_id            = lookup(var.management_vpc, "route_table", null)
#  destination_cidr_block    = each.value.cidr_block
#  vpc_peering_connection_id = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
#}
#
