resource "aws_security_group" "main" {
  name        = "${var.project_name}-SG01"
  description = "Standard Access"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-SG01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rdp" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 3389
  ip_protocol = "tcp"
  to_port     = 3389
  tags = {
    Name = "RDP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0" # Replace with your trusted IP
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  tags = {
    Name = "SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "icmp"
  to_port     = -1
  tags = {
    Name = "ICMP"
  }
}

resource "aws_vpc_security_group_egress_rule" "internet_out" {
  security_group_id = aws_security_group.main.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
  tags = {
    Name = "Internet-Out"
  }
}
