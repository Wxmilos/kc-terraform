resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = huaweicloud_vpc_eip.dedicated.address
  instance_id = huaweicloud_compute_instance.basic[0].id
}
