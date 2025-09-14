# Define the IAM role
resource "aws_iam_role" "ec2_win_ssm_access" {
  name = "ec2-win-ssm-access"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# SSM role for fleet manager
resource "aws_iam_instance_profile" "ec2_win_ssm_access" {
  name = "ec2-win-ssm-access"
  role = aws_iam_role.ec2_win_ssm_access.name
}

# Network interface
resource "aws_network_interface" "nic01" {
  subnet_id       = aws_subnet.subnet01.id
  private_ips     = ["10.0.1.10"]
  security_groups = [aws_security_group.main.id]
}

# Add EIP only if needed for public IP
resource "aws_eip" "eip01" {
  domain = "vpc"
  network_interface         = aws_network_interface.nic01.id
  associate_with_private_ip = "10.0.1.10"
  depends_on                = [aws_internet_gateway.gw]
}

# EC2 instances
resource "aws_instance" "ap01" {
  ami               = "ami-0992e77a19022a98d"
  instance_type     = "t3.medium"
  availability_zone = "us-west-2a"
  key_name          = "windows-keypair"

  root_block_device {
    volume_size           = 80
    volume_type           = "gp3"
    delete_on_termination = true
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic01.id
  }

  tags = {
    Name = "AP01"
  }

  # Attach the instance profile to the EC2 instance
  iam_instance_profile = aws_iam_instance_profile.ec2_win_ssm_access.name
}
