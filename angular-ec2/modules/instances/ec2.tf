resource "aws_security_group" "allow_traffic" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "angular_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_traffic.name]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y git
              curl -sL https://deb.nodesource.com/setup_16.x | bash -
              apt-get install -y nodejs
              git clone ${var.github_repo} /home/ubuntu/repo
              cd /home/ubuntu/repo
              npm install
              sudo npm run build --prod
              sudo npm install -g http-server
              sudo http-server ./dist/angular-rxjs-infite-scroll -p 8080 &
              EOF

  tags = {
    Name = "AngularAppDeployment"
  }
}

output "instance_ip" {
  value = aws_instance.angular_app.public_ip
}
