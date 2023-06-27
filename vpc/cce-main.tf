resource "huaweicloud_cce_cluster" "test" {
  name                   = "cluster"
  flavor_id              = "cce.s2.small"
  vpc_id                 = huaweicloud_vpc.vpc_1.id
  subnet_id              = huaweicloud_vpc_subnet.subnet_1.id
  container_network_type = "eni"
  eni_subnet_id          = join(",", [
    huaweicloud_vpc_subnet.subnet_1.ipv4_subnet_id,
  ])
  extend_param = {
    "kubernetes.io/cpuManagerPolicy" = "static"
  }
  
  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1
}
