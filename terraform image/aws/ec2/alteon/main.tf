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
    key = "aws/alteon/aleksandr-karmazin.tfstate"
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
