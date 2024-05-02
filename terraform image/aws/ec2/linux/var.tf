variable "instance_type" {
    default = "t3.micro"
}
variable "region" {
    default = "eu-north-1"
}

variable "ami" {

}

variable "instance_name" {
    default = "test-name"
}

variable "subnet_id" {

}

variable "associate_public_ip" {
    default = false
}