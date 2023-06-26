resource "huaweicloud_vpc_eip" "dedicated" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    share_type  = "PER"
    name        = var.bandwidth_name
    size        = 10
    charge_mode = "traffic"
  }
}
resource "huaweicloud_vpc_eip" "dedicated_elb" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    share_type  = "PER"
    name        = var.bandwidth_name_elb
    size        = 10
    charge_mode = "traffic"
  }
}

