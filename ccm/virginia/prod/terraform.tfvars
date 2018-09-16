### Terragrunt module
terragrunt = {
  terraform {
    source = "github.com/Lowess/terraform-aws-vpc.git//?ref=stable"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

### Module variables
name = "ccm"
cidr = "172.20.0.0/16"

azs = ["us-east-1a"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC682KRy2IA60/h3HY9xZOHw/pJcvp7guIlRj5T+w77JNkD3JFf93FKnuunE4HEFOjh0+HXmmYtyZn4bsIh67REWYkb669Jbw0IUnWvNR3ivk+541EVAFG4ocyw55uyTqPL8iIAJ4QOGgw3Pm9nU/H7tbMFP7rCi7z3ybT+MsiFNj1TBSL2kSyMDHmFWH4wtdTOu6X6NZ98Nf3eJIAwlpofSwWn/xLMDFL3Q38aVSKRIX8jSuBr2Mf1Zo6iKBySNhSkvNzojsBAR/HungB5627iwZTSeART0KSAFX1jkD/DWduNjOAr0tkF5JKuxDjcGoMITpLA2iSpoQNwcGqNrBQH florian@aws-educate.com"
