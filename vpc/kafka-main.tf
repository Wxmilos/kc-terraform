variable "availability_zones" {
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
variable "flavor_id" {
  default = "c6.2u4g.cluster"
}
variable "storage_spec_code" {
  default = "dms.physical.storage.ultra.v2"
}

data "huaweicloud_dms_kafka_flavors" "test" {
  type               = "cluster"
  flavor_id          = var.flavor_id
  availability_zones = var.availability_zones
  storage_spec_code  = var.storage_spec_code
}

resource "huaweicloud_dms_kafka_instance" "test" {
  name              = "kafka_test"
  vpc_id            = huaweicloud_vpc.vpc_1.id
  network_id        = huaweicloud_vpc_subnet.subnet_1.id
  security_group_id = var.security_group_id

  flavor_id          = var.flavor_id
  storage_spec_code  = var.storage_spec_code
  availability_zones = var.availability_zones
  engine_version     = "2.7"
  storage_space      = 300
  broker_num         = 3

  access_user = "user"
  password    = "Huawei@321!"

  manager_user     = "kafka_manager"
  manager_password = "Huawei@321!"
  
  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1

  depends_on = ["data.huaweicloud_dms_kafka_flavors.test"]
}

resource "huaweicloud_dms_kafka_topic" "topic" {
  instance_id = huaweicloud_dms_kafka_instance.test.id
  name        = "topic_1"
  partitions  = 20
  replicas    = 1
#过期时间(h)
  aging_time  = 72
#是否开启同步复制
#  sync_replication = true
#是否开启同步刷新
#  sync_flushing = true
}
