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
    key = "aws/lambda/aleksandr-karmazin.tfstate"
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

provider "aws" {
    region = "eu-north-1"
}

resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = "sts:AssumeRole",
                Effect = "Allow",
                Principal = {
                    Service = "lambda.amazonaws.com"
                },
            },
        ],
    })
}

resource "aws_lambda_function" "test" {
    filename = "lambda_function.zip"
    function_name = "test_lambda_function_name"
    role = aws_iam_role.lambda_role.arn
    handler = "lambda_function.lambda_handler"

    source_code_hash = filebase64sha256("function.zip")

    runtime = "python3.8"
}