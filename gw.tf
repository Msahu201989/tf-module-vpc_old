resource "aws_internet_gateway" "gw" {
  count = length(local.vpc_ids)
  vpc_id = element(local.vpc_ids, count.index)

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_eip" "ngw" {
  vpc    =  true
}

#resource "aws_nat_gateway" "ngw" {
#  allocation_id = aws_eip.ngw.id
#  subnet_id     = "aws_subnet.example.id"
#
#  tags = {
#    Name = "gw NAT"
#  }
#}

locals {
  private_route_tables = [for i, j in module.private_subnets: j.rt]
}

output "test" {
  value = local.private_route_tables
}

#resource "aws_route" "internet_gateway_route_to_public_subnets" {
#  count                     = length(????)
#  route_table_id            = element(???, count.index)
#  destination_cidr_block    = each.value.cidr_block
#  vpc_peering_connection_id = aws_vpc_peering_connection.management-vpc-to-env-vpc.*.id[0]
#}