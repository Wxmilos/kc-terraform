resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.test.id
  name                     = "testpool"
  os                       = "EulerOS 2.9"
  initial_node_count       = 0
  flavor_id                = "c7n.xlarge.2"
  availability_zone        = "ap-southeast-1c"
  password		   = "Huawei@321!"
  scall_enable             = false
#  min_node_count           = 1
#  max_node_count           = 10
#  scale_down_cooldown_time = 100
#  priority                 = 1
#  type                     = "vm"

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
  storage {
    selectors {
      name              = "cceUse"
      type              = "evs"
      match_label_size  = "100"
      match_label_count = "1"
    }
    
    groups {
      name           = "vgpaas"
      selector_names = ["cceUse"]
      cce_managed    = true

      virtual_spaces {
        name        = "kubernetes"
        size        = "10%"
        lvm_lv_type = "linear"
      }
      virtual_spaces {
        name        = "runtime"
        size        = "90%"
      }
    }
  }
  charging_mode            = "prePaid"
  period_unit              = "month"
  period                   = 1
  lifecycle {
    ignore_changes = [
      data_volumes.0.extend_params, root_volume.0.extend_params,
    ]
  }
}
