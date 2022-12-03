module "lm-subnets" {
  for_each = var.subnets
  subnets = each.value.cidr_block
  source = "./lm-subnets"
  vpc_id = var.vpc_id
}