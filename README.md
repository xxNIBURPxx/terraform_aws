# AWS Terraform Guide -- VPC, Subnet, Security, and EC2

This guide explains how to deploy a basic AWS environment using
Terraform.\
It includes a **VPC, Subnet, Internet Gateway, Route Table, Security
Groups, IAM Role, Elastic IP, and an EC2 Instance**.

------------------------------------------------------------------------

## 📂 Project Structure

    .
    ├── provider.tf
    ├── vpc.tf
    ├── subnet.tf
    ├── security.tf
    ├── ec2.tf
    ├── variables.tf
    └── README.md

------------------------------------------------------------------------

## 🔧 Prerequisites

-   [Terraform](https://developer.hashicorp.com/terraform/downloads)
    installed (v1.6+ recommended)
-   AWS credentials configured in one of the following ways:
    -   `~/.aws/credentials`
    -   Environment variables (`AWS_ACCESS_KEY_ID`,
        `AWS_SECRET_ACCESS_KEY`)
    -   IAM role (if running from AWS CloudShell or EC2)

------------------------------------------------------------------------

## 🚀 Getting Started

### 1. Initialize Terraform

``` bash
terraform init
```

### 2. Review the Plan

``` bash
terraform plan
```

### 3. Apply the Configuration

``` bash
terraform apply
```

### 4. Destroy (Clean Up)

``` bash
terraform destroy
```

------------------------------------------------------------------------

## 🏗 Resources Created

1.  **VPC**
    -   CIDR: `10.0.0.0/16`
    -   Name: `InsertName-VPC01`
2.  **Subnet**
    -   CIDR: `10.0.1.0/24`
    -   AZ: `us-west-2a`
    -   Name: `InsertName-PROD`
3.  **Internet Gateway & Route Table**
    -   Provides public internet access
    -   Routes for IPv4 (`0.0.0.0/0`) and IPv6 (`::/0`)
4.  **Security Group**
    -   Allows **RDP (3389)**, **SSH (22)**, and **ICMP (Ping)**
    -   Allows all outbound traffic
5.  **IAM Role & Instance Profile**
    -   Grants EC2 access to AWS SSM (Fleet Manager, Session Manager,
        etc.)
6.  **Elastic IP**
    -   Assigned to EC2 instance network interface
7.  **EC2 Instance**
    -   AMI: Windows Server (example: `ami-0992e77a19022a98d`)
    -   Type: `t3.medium`
    -   Root volume: `gp3`, 80GB
    -   Key Pair: `windows-keypair`

------------------------------------------------------------------------

## 🔒 Security Notes

-   **RDP (3389)** and **SSH (22)** are currently open to `0.0.0.0/0`.\
    👉 Update to your trusted IP range for better security.
-   Replace placeholder names (`InsertName`) with your project or
    environment name.
-   Ensure your `key_name` matches an existing AWS EC2 key pair.

------------------------------------------------------------------------

## 📌 Variables (variables.tf)

``` hcl
variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "project_name" {
  type    = string
  default = "InsertName"
}
```

------------------------------------------------------------------------

## 🧹 Cleanup

When finished, run:

``` bash
terraform destroy
```

This removes all resources to avoid unnecessary AWS costs.

------------------------------------------------------------------------

## 📖 Next Steps

-   Add more subnets for HA across multiple AZs
-   Create NAT Gateway & private subnets
-   Use Terraform modules for reusability
-   Integrate with S3 backend & remote state

------------------------------------------------------------------------

**Author:** Phillip Rubin
