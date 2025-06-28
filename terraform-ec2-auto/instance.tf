resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = "t3.micro"
  key_name               = "dev-key"
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  subnet_id              = aws_subnet.dev_subnet.id

  tags = {
    Name    = "DevInstance"
    Project = "DevOpsProject"
  }
}