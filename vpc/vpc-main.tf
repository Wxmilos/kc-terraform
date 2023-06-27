terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = "1.50.0"
    }
  }
}


resource "huaweicloud_vpc" "vpc_1" {
  name = var.vpc_name
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "subnet_1" {
  vpc_id      = huaweicloud_vpc.vpc_1.id
  name        = var.subnet_name
  cidr        = var.subnet_cidr
  gateway_ip  = var.subnet_gateway
  primary_dns = var.primary_dns
  ipv6_enable = true
}
#堡垒机
#resource "huaweicloud_cbh_instance" "cbh_test" {
#  flavor_id         = "cbh.basic.10"
#  name              = var.cbh_name
#  vpc_id            = huaweicloud_vpc.vpc_1.id
#  subnet_id         = huaweicloud_vpc_subnet.subnet_1.id
#  security_group_id = var.security_group_id
#  availability_zone = var.availability_zone
#  password          = var.password
#  charging_mode     = "prePaid"
#  period_unit       = "month"
#  period            = 1
#}

