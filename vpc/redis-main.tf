resource "huaweicloud_dcs_instance" "instance_1" {
  name               = "redis_cluster_instance"
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = "16"
  flavor             = "redis.cluster.xu1.large.r3.s4.16"
  availability_zones = [
    "ap-southeast-1a",
    "ap-southeast-1b",
  ]
  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1
  auto_pay = true
  password           = "Huawei@321!"
  vpc_id             = huaweicloud_vpc.vpc_1.id
  subnet_id          = huaweicloud_vpc_subnet.subnet_1.id
}
