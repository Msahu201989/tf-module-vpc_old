#output "private_subnets" {
#  value = module.private_subnets
#}
#
output "public_subnets" {
  value = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[0].id 
}
#
#
#output "all_route_tables" {
#  value = "local.all_route_tables"
#}
#

#output "test" {
#  value = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[0].id
#}
