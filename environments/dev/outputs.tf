output "vpc_id" {
  description = "ID de la VPC de datos."
  value       = module.network.vpc_id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas."
  value       = module.network.private_subnet_ids
}

output "s3_endpoint_id" {
  description = "ID del S3 Gateway Endpoint."
  value       = module.network.s3_endpoint_id
}