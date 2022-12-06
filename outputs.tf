output "private_subnets" {
  value = module.private_subnets
}

output "public_subnets" {
  value = module.public_subnets
}


#output "all_private_subnets" {
#  value = [for k, v in module.private_subnets : v.subnets]
#}
