variable "location" {
    default = "us-east-1"
}

variable "os_name" {
    default = "ami-01bc990364452ab3e"
}

variable "key" {
    default = "01-keypair"
}

variable "instance-type" {
    default = "t2.small"
}

variable "vpc-cidr" {
    default = "10.10.0.0/16"  
}

variable "public_subnet1-cidr" {
    default = "10.10.1.0/24"
  
}
variable "public_subnet2-cidr" {
    default = "10.10.2.0/24"
}
variable "private_subnet1-cidr" {
    default = "10.10.3.0/24"
  
}
variable "private_subnet2-cidr" {
    default = "10.10.4.0/24"
}
variable "subnet_az-1" {
    default =  "us-east-1a"  
}

variable "subnet_az-2" {
    default =  "us-east-1b"  
}
