data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  account_id = data.aws_caller_identity.current.account_id

  # Recursos del backend, armados con la convención de nombres del bootstrap
  state_bucket_arn = "arn:aws:s3:::${var.project_name}-tfstate-${local.account_id}"
  lock_table_arn   = "arn:aws:dynamodb:${var.region}:${local.account_id}:table/${var.project_name}-tf-locks"
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

module "identity" {
  source = "../../modules/identity"

  name_prefix     = local.name_prefix
  data_bucket_arn = module.storage.bucket_arn  # ← output de storage
  data_prefix     = module.storage.data_prefix # ← output de storage

  audited_bucket_arns = [module.storage.bucket_arn, local.state_bucket_arn]
  audited_table_arns  = [local.lock_table_arn]
}