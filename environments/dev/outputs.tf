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

output "exec_role_arn" {
  description = "ARN del rol de ejecución."
  value       = module.identity.exec_role_arn
}

output "audit_role_arn" {
  description = "ARN del rol de auditoría."
  value       = module.identity.audit_role_arn
}

output "data_lake_bucket_name" {
  description = "Bucket del Data Lake."
  value       = module.storage.bucket_name
}