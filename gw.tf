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
  public_route_tables = [for i, j in module.public_subnets: j.rt]
}

resource "aws_route" "internet_gateway_route_to_public_subnets" {
  count                  = length(local.public_route_tables)
  route_table_id         = element(local.public_route_tables, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[0].id
}