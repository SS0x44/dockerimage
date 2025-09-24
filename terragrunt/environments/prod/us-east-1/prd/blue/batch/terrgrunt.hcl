terraform {
  source = ""
}

include "root" {
  path = find_in_parent_folder("backend.hcl")
}

locals {
  account_vars   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  namespace_vars = read_terragrunt_config(find_in_parent_folders("ns.hcl"))

  aws_region    = local.account_vars.locals.aws_region
  account_name  = local.account_vars.locals.account_name
  account_id    = local.account_vars.locals.account_id
  account_type  = local.account_vars.locals.account_type
  vpc_id        = local.account_vars.locals.vpc_id
  vpc_name      = local.account_vars.locals.vpc_name
  assume_role   = local.account_vars.locals.assume_role
  environment   = local.env_vars.locals.environment
  namespace     = local.namespace_vars.locals.namespace
}
inputs          = {




}
