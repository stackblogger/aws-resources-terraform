provider "aws" {
  region = var.region
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

  owners = ["099720109477"] // Canonical
}

module "instances" {
  source         = "./modules/instances"
  github_repo_url = var.github_repo_url
  ami_id          = data.aws_ami.ubuntu.id
  public_key_path = var.public_key_path
  instance_type   = var.instance_type
}
