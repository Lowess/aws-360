### Terragrunt module
terragrunt = {
  terraform {
    source = "github.com/Lowess/terraform-aws-vpc.git//?ref=stable"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

aws_profile = "victorien"

### Module variables
name = "ccm"
cidr = "172.20.0.0/16"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

# aws-educate-students
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgb4KJX+Rtdm4rfAllGeviFxt1ONlj8zwbHaaoCIbpBr52re3xT1LND/tiQyool0qL9iZQIjd89//EPXNzlvNPXM+XJhN5A2zgTmHanAoJt+6N6LDJRCUYfRI9ooJzkWsraB7IqAPe1/lxb8OH0LZjS+OYoGn/0zVzlEeKZlSJSSf+GF98AHKcWxvUVpU/E++Q7fmsHdCCYDzxf6SGpUzgVC+WiIJN/u+c2uAIF0ZJ/mdgBZhOi85ISuVfnXeYKvxVfZry7jsLjVCJrLOBBdWCY5twHgsCdjKWDqkfVRVNoam/2e+QKsJnyxg8ajlYLVrQCiIXgf9S6KjMc4VtvOqP"
