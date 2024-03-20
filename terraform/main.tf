resource "aws_security_group" "my_cloud_app_sg" {
  name        = "my_cloud_app"
  description = "Security group for my cloud app"
  vpc_id      = "vpc-0a7754656e76e389f0" # VPC-ID aus deinem Bild

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
  vpc_security_group_ids = [aws_security_group.my_cloud_app_sg.id]
  
  # Hier definierst du das Subnetz, falls erforderlich. Dieses müsste zuerst definiert werden.
  # subnet_id = aws_subnet.mein_subnetz.id

  tags = {
    Name = "ExampleInstance"
  }
}

# Für den Fall dass ich ein Subnetz brauche. Eig aber nicht: 

# resource "aws_subnet" "mein_subnetz" {
#   vpc_id     = "vpc-0a7754656e76e389f0" # Meine VPC-ID
#   cidr_block = "172.31.0.0/20" # Ein Subnetz meiner VPC-CIDR
#   // Weitere Konfigurationen ...
# }
