resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "dev-security-group"
  tags = {
    Name = "dev-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshFromMyIP" {
  security_group_id = aws_security_group.dev-sg.id
  cidr_ipv4         = "192.168.1.1/32" # Replace with your actual IP address
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allowHTTP" {
  security_group_id = aws_security_group.dev-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutboundIPv4" {
  security_group_id = aws_security_group.dev-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allowAllOutboundIPv6" {
  security_group_id = aws_security_group.dev-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}