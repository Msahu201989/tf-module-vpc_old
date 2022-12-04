resource "aws_subnet" "main" {
  count      = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = element(var.cidr_block, count.index)
  tags       = local.subnets_tags
  availability_zone = element(var.subnet_availability_zones, count.index)
}