locals {
  app_id      = ""
  app_prefix  = ""
  common_tags {
    

  }
  account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  namespace_vars =  read_terragrunt_config(find_in_parent_folders("namespace.hcl"))

  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  region_short = local.region_vars.locals.aws_region_short

}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "${locals.app_id}-${locals.app_prefix}-${locals.account_name}-resources${locals.region_short}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region        = "${local.aws_region}"
    encrypt        = true
    use_lockfile   = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}
provider "aws" {
   region = "${local.aws_region}"
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
