variable "region" {
    default = "eu-north-1"
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string
}

variable "instance_type" {
    description = "Type of the EC2 instance"
    default = "t3.micro"
}

variable "instance_name" {
    description = "EC2 instance name"
    default = "test-name"
}