terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "http://10.196.203.149:32694"
    }
    bucket = "terraform"
    key = "aws/ec2/linux/aleksandr-karmazin.tfstate"
    region = "main"
    access_key = "terraform"
    secret_key = "terraformSecretKey!"
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_metadata_api_check = true
    skip_region_validation = true
    use_path_style = true
    workspace_key_prefix = ""
  }
}

resourcce "aws_instance" "linux_instance" {
  ami = "ami-03c3351e3ce9d04eb"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.discovery_sg.id]

  tags = {
    Name = "Linux ec2 instance for testing"
  }
}

resource "aws_seurity_group" "discovery_sg" {
  name = "discovery-instance-sg"
}


