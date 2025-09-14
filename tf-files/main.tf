######################################################
# main.tf - Entry point for Terraform AWS deployment #
######################################################

# This file references modular .tf configurations in this directory:
#   - provider.tf   : AWS provider configuration
#   - variables.tf  : Input variables
#   - network.tf    : VPC, Subnets, Routes, Internet Gateway
#   - security.tf   : Security Groups and Rules
#   - ec2.tf        : IAM, Elastic IP, EC2 instance

# Terraform automatically loads all *.tf files in this directory.
# You can run the following commands from this folder:

# Initialize Terraform
#   terraform init
#
# Review the execution plan
#   terraform plan
#
# Apply the configuration
#   terraform apply
#
# Destroy all resources
#   terraform destroy

# No additional resources are defined here, as everything is modularized.
