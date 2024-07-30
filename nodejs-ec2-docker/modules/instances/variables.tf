variable "github_repo_url" {
  description = "The URL of the GitHub repository containing the Node.js application."
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance."
  type        = string
}

variable "public_key_path" {
  description = "The path to the public SSH key file."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
  type        = string
}
