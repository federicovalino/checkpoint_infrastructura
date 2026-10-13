# PLAN_OUTPUT

Salida de `terraform plan` del entorno dev (ID de cuenta enmascarado).

```text

Warning: Deprecated Parameter

The parameter "dynamodb_table" is deprecated. Use parameter "use_lockfile" instead.
Acquiring state lock. This may take a few moments...
module.network.data.aws_availability_zones.available: Reading...
module.identity.data.aws_caller_identity.current: Reading...
module.storage.data.aws_caller_identity.current: Reading...
data.aws_caller_identity.current: Reading...
module.network.data.aws_region.current: Reading...
module.identity.data.aws_region.current: Reading...
module.network.data.aws_region.current: Read complete after 0s [id=us-east-1]
module.identity.data.aws_region.current: Read complete after 0s [id=us-east-1]
module.identity.data.aws_caller_identity.current: Read complete after 0s [id=<ACCOUNT_ID>]
module.identity.data.aws_iam_policy_document.audit_trust: Reading...
module.identity.data.aws_iam_policy_document.exec_trust: Reading...
module.identity.data.aws_iam_policy_document.exec_trust: Read complete after 0s [id=2640123283]
module.identity.data.aws_iam_policy_document.audit_trust: Read complete after 0s [id=913206027]
data.aws_caller_identity.current: Read complete after 0s [id=<ACCOUNT_ID>]
module.storage.data.aws_caller_identity.current: Read complete after 0s [id=<ACCOUNT_ID>]
module.network.data.aws_availability_zones.available: Read complete after 1s [id=us-east-1]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # module.identity.data.aws_iam_policy_document.audit_permissions will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "audit_permissions" {
      + id            = (known after apply)
      + json          = (known after apply)
      + minified_json = (known after apply)

      + statement {
          + actions   = [
              + "ec2:DescribeRouteTables",
              + "ec2:DescribeSecurityGroups",
              + "ec2:DescribeSubnets",
              + "ec2:DescribeVpcEndpoints",
              + "ec2:DescribeVpcs",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "ReadNetworkConfig"

          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "us-east-1",
                ]
              + variable = "aws:RequestedRegion"
            }
        }
      + statement {
          + actions   = [
              + "s3:GetBucketLocation",
              + "s3:GetBucketPolicy",
              + "s3:GetBucketPublicAccessBlock",
              + "s3:GetBucketTagging",
              + "s3:GetBucketVersioning",
              + "s3:GetEncryptionConfiguration",
            ]
          + effect    = "Allow"
          + resources = [
              + "arn:aws:s3:::dataplatform-tfstate-<ACCOUNT_ID>",
              + (known after apply),
            ]
          + sid       = "ReadBucketConfig"
        }
      + statement {
          + actions   = [
              + "dynamodb:DescribeTable",
            ]
          + effect    = "Allow"
          + resources = [
              + "arn:aws:dynamodb:us-east-1:<ACCOUNT_ID>:table/dataplatform-tf-locks",
            ]
          + sid       = "ReadLockTableConfig"
        }
      + statement {
          + actions   = [
              + "iam:GetPolicy",
              + "iam:GetPolicyVersion",
              + "iam:GetRole",
              + "iam:ListAttachedRolePolicies",
              + "iam:ListPolicyVersions",
              + "iam:ListRolePolicies",
            ]
          + effect    = "Allow"
          + resources = [
              + "arn:aws:iam::<ACCOUNT_ID>:policy/dataplatform-dev-*",
              + "arn:aws:iam::<ACCOUNT_ID>:role/dataplatform-dev-*",
            ]
          + sid       = "ReadProjectIam"
        }
    }

  # module.identity.data.aws_iam_policy_document.exec_permissions will be read during apply
  # (config refers to values not yet known)
 <= data "aws_iam_policy_document" "exec_permissions" {
      + id            = (known after apply)
      + json          = (known after apply)
      + minified_json = (known after apply)

      + statement {
          + actions   = [
              + "s3:ListBucket",
            ]
          + effect    = "Allow"
          + resources = [
              + (known after apply),
            ]
          + sid       = "ListOnlyDataPrefix"

          + condition {
              + test     = "StringLike"
              + values   = [
                  + "raw/",
                  + "raw/*",
                ]
              + variable = "s3:prefix"
            }
        }
      + statement {
          + actions   = [
              + "s3:GetObject",
              + "s3:PutObject",
            ]
          + effect    = "Allow"
          + resources = [
              + (known after apply),
            ]
          + sid       = "ReadWriteOnlyDataPrefix"
        }
    }

  # module.identity.aws_iam_policy.audit will be created
  + resource "aws_iam_policy" "audit" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Lectura de configuración de red, almacenamiento e IAM del entorno."
      + id               = (known after apply)
      + name             = "dataplatform-dev-auditor-readonly"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = (known after apply)
      + policy_id        = (known after apply)
      + tags_all         = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "dataplatform"
        }
    }

  # module.identity.aws_iam_policy.exec will be created
  + resource "aws_iam_policy" "exec" {
      + arn              = (known after apply)
      + attachment_count = (known after apply)
      + description      = "Lectura/escritura sobre un único prefijo del Data Lake."
      + id               = (known after apply)
      + name             = "dataplatform-dev-ingest-exec-s3"
      + name_prefix      = (known after apply)
      + path             = "/"
      + policy           = (known after apply)
      + policy_id        = (known after apply)
      + tags_all         = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "dataplatform"
        }
    }

  # module.identity.aws_iam_role.audit will be created
  + resource "aws_iam_role" "audit" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Condition = {
                          + Bool = {
                              + "aws:MultiFactorAuthPresent" = "true"
                            }
                        }
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "arn:aws:iam::<ACCOUNT_ID>:root"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Rol de auditoría: lectura de configuración, sin acceso a datos."
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "dataplatform-dev-auditor"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "dataplatform"
        }
      + unique_id             = (known after apply)

      + inline_policy (known after apply)
    }

  # module.identity.aws_iam_role.exec will be created
  + resource "aws_iam_role" "exec" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Condition = {
                          + StringEquals = {
                              + "aws:SourceAccount" = "<ACCOUNT_ID>"
                            }
                        }
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Rol de ejecución del proceso de ingesta (Lambda)."
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "dataplatform-dev-ingest-exec"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "dataplatform"
        }
      + unique_id             = (known after apply)

      + inline_policy (known after apply)
    }

  # module.identity.aws_iam_role_policy_attachment.audit will be created
  + resource "aws_iam_role_policy_attachment" "audit" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "dataplatform-dev-auditor"
    }

  # module.identity.aws_iam_role_policy_attachment.exec will be created
  + resource "aws_iam_role_policy_attachment" "exec" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "dataplatform-dev-ingest-exec"
    }

  # module.network.aws_default_security_group.this will be created
  + resource "aws_default_security_group" "this" {
      + arn                    = (known after apply)
      + description            = (known after apply)
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "us-east-1"
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "dataplatform-dev-default-sg-locked"
        }
      + tags_all               = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-default-sg-locked"
          + "Project"     = "dataplatform"
        }
      + vpc_id                 = (known after apply)
    }

  # module.network.aws_route_table.private will be created
  + resource "aws_route_table" "private" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + region           = "us-east-1"
      + route            = (known after apply)
      + tags             = {
          + "Name" = "dataplatform-dev-private-rt"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-private-rt"
          + "Project"     = "dataplatform"
        }
      + vpc_id           = (known after apply)
    }

  # module.network.aws_route_table_association.private[0] will be created
  + resource "aws_route_table_association" "private" {
      + id             = (known after apply)
      + region         = "us-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.network.aws_route_table_association.private[1] will be created
  + resource "aws_route_table_association" "private" {
      + id             = (known after apply)
      + region         = "us-east-1"
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # module.network.aws_subnet.private[0] will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.20.10.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "us-east-1"
      + tags                                           = {
          + "Name" = "dataplatform-dev-private-us-east-1a"
          + "Tier" = "private"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-private-us-east-1a"
          + "Project"     = "dataplatform"
          + "Tier"        = "private"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.network.aws_subnet.private[1] will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.20.11.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "us-east-1"
      + tags                                           = {
          + "Name" = "dataplatform-dev-private-us-east-1b"
          + "Tier" = "private"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-private-us-east-1b"
          + "Project"     = "dataplatform"
          + "Tier"        = "private"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.network.aws_vpc.this will be created
  + resource "aws_vpc" "this" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.20.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + region                               = "us-east-1"
      + tags                                 = {
          + "Name" = "dataplatform-dev-vpc"
        }
      + tags_all                             = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-vpc"
          + "Project"     = "dataplatform"
        }
    }

  # module.network.aws_vpc_endpoint.s3 will be created
  + resource "aws_vpc_endpoint" "s3" {
      + arn                   = (known after apply)
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + ip_address_type       = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = (known after apply)
      + region                = "us-east-1"
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.us-east-1.s3"
      + service_region        = (known after apply)
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + tags                  = {
          + "Name" = "dataplatform-dev-s3-gateway-endpoint"
        }
      + tags_all              = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Name"        = "dataplatform-dev-s3-gateway-endpoint"
          + "Project"     = "dataplatform"
        }
      + vpc_endpoint_type     = "Gateway"
      + vpc_id                = (known after apply)

      + dns_options (known after apply)

      + subnet_configuration (known after apply)
    }

  # module.storage.aws_s3_bucket.data_lake will be created
  + resource "aws_s3_bucket" "data_lake" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "dataplatform-dev-datalake-<ACCOUNT_ID>"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "us-east-1"
      + request_payer               = (known after apply)
      + tags                        = {
          + "DataDomain" = "lakehouse"
        }
      + tags_all                    = {
          + "DataDomain"  = "lakehouse"
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "dataplatform"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # module.storage.aws_s3_bucket_policy.data_lake will be created
  + resource "aws_s3_bucket_policy" "data_lake" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + policy = (known after apply)
      + region = "us-east-1"
    }

  # module.storage.aws_s3_bucket_public_access_block.data_lake will be created
  + resource "aws_s3_bucket_public_access_block" "data_lake" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + region                  = "us-east-1"
      + restrict_public_buckets = true
    }

  # module.storage.aws_s3_bucket_server_side_encryption_configuration.data_lake will be created
  + resource "aws_s3_bucket_server_side_encryption_configuration" "data_lake" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "us-east-1"

      + rule {
          + blocked_encryption_types = (known after apply)
          + bucket_key_enabled       = (known after apply)

          + apply_server_side_encryption_by_default {
              + kms_master_key_id = (known after apply)
              + sse_algorithm     = "AES256"
            }
        }
    }

  # module.storage.aws_s3_bucket_versioning.data_lake will be created
  + resource "aws_s3_bucket_versioning" "data_lake" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "us-east-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

Plan: 19 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + audit_role_arn        = (known after apply)
  + data_lake_bucket_name = "dataplatform-dev-datalake-<ACCOUNT_ID>"
  + exec_role_arn         = (known after apply)
  + private_subnet_ids    = [
      + (known after apply),
      + (known after apply),
    ]
  + s3_endpoint_id        = (known after apply)
  + vpc_id                = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
```
