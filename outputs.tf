output "private_subnets" {
  value = module.private_subnets
}

#output "public_subnets" {
#  value = module.public_subnets
#}
#


output "test" {
  value = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[*].id
}