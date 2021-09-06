provider "aws" {
  access_key = "AKIAQ4PCJB3E3J5W2AWA"
  secret_key = "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"
  region     = "us-west-2"
}


resource "aws_eip" "static_ip" {
  instance = aws_instance.web.id
  vpc      = true
}


resource "aws_instance" "web" {
  ami                    = "ami-03d5c68bab01f3496" # Ubuntu_20.04
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data              = file("user_data.sh")

  tags = {
    name = "prod.server"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "" {

}


resource "aws_security_group" "web" {
  name        = "web_security_group"
  description = "inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
