locals {
  name_prefix = "${var.project_name}-${var.environment}" # dataplatform-dev
}

module "network" {
  source = "../../modules/network"

  name_prefix = local.name_prefix
  vpc_cidr    = var.vpc_cidr
  az_count    = 2
}