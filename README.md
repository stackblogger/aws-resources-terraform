# aws-resources-terraform

Welcome to the Terraform AWS Resource Management repository! This repository contains Terraform scripts to help you quickly and efficiently create and manage various AWS resources, including EC2 instances, AWS Lambda functions, Elastic Container Registry (ECR), Amazon Elastic Kubernetes Service (EKS), and more.

## Table of Contents

- [Getting Started](#getting-started)
- [Folder Structure](#folder-structure)
- [Usage](#usage)
- [Prerequisites](#prerequisites)

## Getting Started

To get started with this repository, simply clone it to your local machine. You'll find separate folders for each type of AWS resource, each containing its own `main.tf` file that defines the infrastructure.

```bash
git clone https://github.com/stackblogger/aws-resources-terraform.git
cd aws-resources-terraform
```

## Folder Structure

The repository is organized into the following folders:

- **simple-ec2/**: Contains Terraform scripts to create and update simple AWS EC2 instance.
- **angular-ec2/**: Contains Terraform scripts to deploy Angular application to AWS EC2 instance.

Each folder includes a `main.tf` file that contains the Terraform configurations.


## Usage

1. Navigate to the desired resource folder

```bash
cd <resource-folder>
```

Replace <resource-folder> with the folder name (e.g., simple-ec2, angular-ec2).

2. Run the following commands to initialize, plan, and apply your Terraform scripts

```bash
terraform init
terraform plan
terraform apply
```

3. Follow the prompts to complete the deployment.

## Prerequisites

Before using these Terraform scripts, ensure you have the following:

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed on your local machine.
- An [AWS account](https://aws.amazon.com/console/) with appropriate permissions to create the resources specified in the scripts.
- AWS credentials configured on your system. You can set this up using the AWS CLI:

```bash
aws configure
```

## Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to create a pull request. Please adhere to the coding standards and ensure that your changes are well-documented.
