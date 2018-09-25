### Terragrunt module
terragrunt = {
  terraform {
    source = "github.com/Lowess/terraform-aws-autoscaling.git//?ref=stable"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

### Set AWS profile for provider
aws_profile = "ccm"

### Feed the discovery module
vpc_name = "ccm"

### Define autoscaling application details
app_key_name = "aws-educate-student"
app_name = "flask-api"
app_count = 3
