data "huaweicloud_compute_flavors" "myflavor" {
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}

data "huaweicloud_images_image" "myimage" {
  name        = "CentOS 8.2 64bit"
  most_recent = true
}


data "huaweicloud_availability_zones" "myaz" {}
#普通资源
resource "huaweicloud_compute_instance" "basic" {
  count = 2 
  name              = "basic-${count.index}"
  image_id          = data.huaweicloud_images_image.myimage.id
  flavor_id         = data.huaweicloud_compute_flavors.myflavor.ids[0]
  security_groups   = ["default"]
  availability_zone = data.huaweicloud_availability_zones.myaz.names[0]

  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1
  auto_pay       = true

  network {
    uuid = huaweicloud_vpc_subnet.subnet_1.id
  }
}
#CCE资源
resource "huaweicloud_compute_instance" "CCE-basic" {
  count = 1
  name              = "CCE-basic-${count.index}"
  image_id          = data.huaweicloud_images_image.myimage.id
  flavor_id         = "c7n.xlarge.2"
  security_groups   = ["default"]
  availability_zone = "ap-southeast-1c"

  charging_mode = "prePaid"
  period_unit   = "month"
  period        = 1
  auto_pay       = true

  network {
    uuid = huaweicloud_vpc_subnet.subnet_1.id
  }
}

