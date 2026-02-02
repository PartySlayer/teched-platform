output "vpc_id" {
  description = "ID della VPC creata"
  value       = module.networking.vpc_id
}

output "public_subnets" {
  description = "ID delle subnet pubbliche"
  value       = module.networking.public_subnet_ids
}

output "private_subnets" {
  description = "ID delle subnet private"
  value       = module.networking.private_subnet_ids
}