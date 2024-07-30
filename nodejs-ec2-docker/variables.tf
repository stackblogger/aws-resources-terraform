variable "github_repo_url" {
  description = "The URL of the GitHub repository containing the Node.js application."
  type        = string
}

variable "public_key_path" {
  description = "The path to the public SSH key file."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1" // Default region; you can change this if necessary
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance."
  type        = string
  default     = "t2.micro" // Default instance type; you can change this if necessary
}
