# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  aws_region      = local.region_vars.locals.aws_region
  aws_region_name = local.region_vars.locals.aws_region_name

  # S3 state configuration
  remote_state_bucket        = "terragrunt-aws-360-${local.aws_region}"
  remote_state_bucket_prefix = "${path_relative_to_include()}/terraform.tfstate"
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "${local.remote_state_bucket}"
    key            = "${local.remote_state_bucket_prefix}"
    region         = local.aws_region
    dynamodb_table = "${local.remote_state_bucket}-locks"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

terraform {
  # Force Terraform to keep trying to acquire a lock for up to 10 minutes
  # if someone else already has the lock.

  extra_arguments "retry_lock" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  {
    "remote_state_bucket" : local.remote_state_bucket,
    "remote_state_bucket_prefix" : local.remote_state_bucket_prefix
  },
  local.region_vars.locals,
  local.environment_vars.locals,
)
