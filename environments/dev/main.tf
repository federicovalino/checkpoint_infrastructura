locals {
  name_prefix = "${var.project_name}-${var.environment}" # dataplatform-dev
}

module "network" {
  source = "../../modules/network"

  name_prefix = local.name_prefix
  vpc_cidr    = var.vpc_cidr
  az_count    = 2
}

module "storage" {
  source = "../../modules/storage"

  name_prefix     = local.name_prefix
  data_prefix     = "raw/"
  allowed_vpce_id = module.network.s3_endpoint_id # ← output de network como input de storage
}

output "data_lake_bucket_name" {
  description = "Bucket del Data Lake."
  value       = module.storage.bucket_name
}