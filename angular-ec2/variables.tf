variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "public_key_path" {
  description = "The path to the SSH public key"
  type        = string
}

variable "private_key_path" {
  description = "The path to the SSH private key"
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
