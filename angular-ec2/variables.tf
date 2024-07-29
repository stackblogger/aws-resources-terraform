variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "public_key_path" {
  description = "The path to the SSH public key"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository URL"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
