variable "access_key" {}

variable "secret_key" {}

variable "region" {}



variable "keypath" {
  default = {
    us-east-1 = "/home/myaws/codes/apachetf/my_AWS.pem"
    us-west-1 = "/home/myaws/codes/apachetf/Key_West1.pem"
  }
}

variable "instance" {
  default = "t2.micro"
}

variable "Ec2Tag" {
  default = "Web Server"
}

variable "ami" {
  default = {
    us-east-1 = "ami-a4dc46db"
    us-west-1 = "ami-8d948ced"
  }
}

variable "key" {
  default = {
    us-east-1 = "my_AWS"
    us-west-1 = "Key_West1"
  }
}

