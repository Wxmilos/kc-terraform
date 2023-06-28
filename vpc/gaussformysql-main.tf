resource "huaweicloud_gaussdb_mysql_instance" "instance_1" {
  name              = "gaussdb_instance_1"
  password          = "Kc-Huawei@321!"
  flavor            = "gaussdb.mysql.4xlarge.x86.4"
  vpc_id            = huaweicloud_vpc.vpc_1.id
  subnet_id         = huaweicloud_vpc.vpc_1.id
  security_group_id = var.security_group_id
  time_zone         = "UTC+08:00"
  volume_size       = "40"
  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1
 
 
  backup_strategy {
    start_time = "03:00-04:00"
    keep_days  = 7
  }
}
