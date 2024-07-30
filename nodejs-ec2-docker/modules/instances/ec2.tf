resource "aws_security_group" "instance_sg" {
  name        = "nodejs-app-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow SSH from everywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow HTTP from everywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // Allow all outgoing traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "nodejs_app" {
  ami                    = var.ami_id
  instance_type         = var.instance_type
  key_name               = aws_key_pair.my_key_pair.key_name
  security_groups        = [aws_security_group.instance_sg.name]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              # Install required packages
              sudo apt-get update
              sudo apt-get install -y docker.io git
              sudo systemctl start docker
              sudo systemctl enable docker

              # Clone the Node.js application from GitHub
              git clone ${var.github_repo_url} /home/ubuntu/nodejs-app

              # Create a Dockerfile for the Node.js application
              cat > /home/ubuntu/nodejs-app/Dockerfile <<EOL
              FROM node:16
              WORKDIR /usr/src/app
              COPY package*.json ./
              RUN npm install
              COPY . .
              CMD [ "npm", "start" ] # Use npm start to start the app
              EOL

              # Navigate to the project directory
              cd /home/ubuntu/nodejs-app

              # Build the Docker image
              sudo docker build -t nodejs-app .

              # Run the Docker container, exposing on port 80 (Replace 3000 with your application’s internal port if necessary)
              sudo docker run -d -p 80:3000 nodejs-app
              EOF

  tags = {
    Name = "NodeJS-Docker-Instance"
  }
}

output "instance_ip" {
  value = aws_instance.nodejs_app.public_ip
}
