### Terragrunt module
terragrunt = {
  terraform {
    source = "github.com/Lowess/terraform-aws-vpc.git//?ref=stable"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

aws_profile = "ccm"

### Module variables
name = "ccm"
cidr = "172.20.0.0/16"

azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

# aws-educate
# public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC682KRy2IA60/h3HY9xZOHw/pJcvp7guIlRj5T+w77JNkD3JFf93FKnuunE4HEFOjh0+HXmmYtyZn4bsIh67REWYkb669Jbw0IUnWvNR3ivk+541EVAFG4ocyw55uyTqPL8iIAJ4QOGgw3Pm9nU/H7tbMFP7rCi7z3ybT+MsiFNj1TBSL2kSyMDHmFWH4wtdTOu6X6NZ98Nf3eJIAwlpofSwWn/xLMDFL3Q38aVSKRIX8jSuBr2Mf1Zo6iKBySNhSkvNzojsBAR/HungB5627iwZTSeART0KSAFX1jkD/DWduNjOAr0tkF5JKuxDjcGoMITpLA2iSpoQNwcGqNrBQH florian@aws-educate.com"

# aws-educate-students
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCgb4KJX+Rtdm4rfAllGeviFxt1ONlj8zwbHaaoCIbpBr52re3xT1LND/tiQyool0qL9iZQIjd89//EPXNzlvNPXM+XJhN5A2zgTmHanAoJt+6N6LDJRCUYfRI9ooJzkWsraB7IqAPe1/lxb8OH0LZjS+OYoGn/0zVzlEeKZlSJSSf+GF98AHKcWxvUVpU/E++Q7fmsHdCCYDzxf6SGpUzgVC+WiIJN/u+c2uAIF0ZJ/mdgBZhOi85ISuVfnXeYKvxVfZry7jsLjVCJrLOBBdWCY5twHgsCdjKWDqkfVRVNoam/2e+QKsJnyxg8ajlYLVrQCiIXgf9S6KjMc4VtvOqP"
