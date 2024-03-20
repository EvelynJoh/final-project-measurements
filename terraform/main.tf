resource "aws_security_group" "my_cloud_app_sg" {
  name        = "my_cloud_app2"
  description = "Security group for my cloud app"
  vpc_id      = "vpc-01644ae1d3efb561b"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["93.229.114.124/32"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["93.229.114.124/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["93.229.114.124/32"]
  }

  egress {
    description = "Outbound traffic for TCP port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyWebServerSG"
  }
}

resource "aws_instance" "web_server" {
  ami                   = "ami-064573ac645743ea8"
  instance_type         = "t2.micro"
  subnet_id             = "subnet-0f328fcb6e1aac22b" // Private Subnetz-ID
  vpc_security_group_ids = [aws_security_group.my_cloud_app_sg.id]
  
  tags = {
    Name = "ExampleInstance"
  }
}
