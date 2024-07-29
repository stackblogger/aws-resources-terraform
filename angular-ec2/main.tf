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

  owners = ["099720109477"] # Canonical
}

module "deploy_angular_app" {
  source          = "./modules/instances"
  key_name        = var.key_name
  public_key_path = var.public_key_path
  github_repo     = var.github_repo
  instance_type   = var.instance_type
  ami_id          = data.aws_ami.ubuntu.id
  private_key_path = var.private_key_path
}

output "instance_ip" {
  value = module.deploy_angular_app.instance_ip
}
