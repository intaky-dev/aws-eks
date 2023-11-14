variable "sg_ids" {
type = string
}

variable "subnet_ids" {
  type = list
}

variable "vpc_id" {
   //default = "vpc-5f680722"
   type = string
}

#variable "oidc_thumbprint_list" {
#  type = list
#}
#variable "user_role" {
#  //default = "your-user"
#  type = string
#}