terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "terraform-ccm-state"
      key            = "ccm/${path_relative_to_include()}/terraform.tfstate"
      region         = "us-east-1"
      dynamodb_table = "terraform-ccm-state"
    }
  }

  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "accounts_settings" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
          "${get_tfvars_dir()}/${find_in_parent_folders("accounts.tfvars")}"
      ]
    }
  }
}
