variable "vpc_name" {
  default = "vpc-basic"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_name" {
  default = "subent-basic"
}

variable "subnet_cidr" {
  default = "172.16.10.0/24"
}

variable "subnet_gateway" {
  default = "172.16.10.1"
}

variable "primary_dns" {
  default = "100.125.1.250"
}
variable "cbh_name" {
  default = "kupo-test"
}
variable "security_group_id" {
  default = "af0e0421-15b5-45b9-8a0b-bcfe99d134bf"
}
variable "password" {
  default = "Huawei@321!"
}
variable "availability_zone" {
  default = "ap-southeast-1a"
}

variable "bandwidth_name" {
  default = "kupo-eip"
}
variable "elb_loadbalancer_name" {
  default = "kupo-elb"
}
variable "bandwidth_name_elb" {
  default = "kupo-elb"
}
variable "elb_listener_name_7" {
  default = "elb-7"
}
variable "elb_listener_name_4" {
  default = "elb-4"
}
