provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "aws_instance_example" {
  ami               = data.aws_ami.ubuntu.id
  instance_type         = "t2.small"

  tags = {
    Name = "AWSAppInstance"
  }
}

output "public_ip" {
  value = aws_instance.aws_instance_example.public_ip
}
