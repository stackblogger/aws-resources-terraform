resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "angular_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  subnet_id     = aws_subnet.main.id

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y git",
      "curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -",
      "sudo apt-get install -y nodejs",
      "git clone ${var.github_repo}",
      "cd ${basename(var.github_repo, ".git")}",
      "npm install",
      "npm run build --prod",
      "sudo npm install -g http-server",
      "nohup http-server ./dist -p 8080 &"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.public_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = "AngularAppDeployment"
  }
}

output "instance_ip" {
  value = aws_instance.angular_app.public_ip
}
