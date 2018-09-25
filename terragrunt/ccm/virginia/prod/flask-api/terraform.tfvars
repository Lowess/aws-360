### Terragrunt module
terragrunt = {
  terraform {
    source = "github.com/Lowess/terraform-aws-autoscaling.git//?ref=stable"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

vpc_name = "ccm"

app_name = "flask-api"
app_count = 1

app_key_name = "aws-educate-student"
