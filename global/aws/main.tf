terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}

resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"

    assume_role_policy = jsoncode({
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