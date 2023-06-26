data "huaweicloud_elb_flavors" "flavors" {
  type            = "L7"
  max_connections = 200000
  cps             = 2000
  bandwidth       = 50
}

data "huaweicloud_elb_flavors" "flavors_4" {
  type            = "L4"
  max_connections = 500000
  cps             = 10000
  bandwidth       = 50
}
#add cert
resource "huaweicloud_elb_certificate" "certificate_1" {
  name        = "certificate_1"
  description = "terraform test certificate"
  domain      = "mykcapiusr.test.com"
  private_key = <<EOT
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQDTF9Eq1/DxDEfNh3NN4KYXlO3lJfnTPfK1TrYeJ6JRkTLTaXEd
4aknQrr3VpkTgMWN+5pTZqIq7VXgtnX7oCw5X8ZFkZY41+a2Mx0txoLX1dbvzmN2
MChsweqPv+03M1zQtrH09YN60daUdkq6ZFhdLDR0dw6Bw+wy4NuZmzqavQIDAQAB
AoGBAJxCWCqv2QKGhaxl5Pu0HR79trBW0T0G8WA3GObvjd91bTtEJWDqR63xXrdy
2jOusg6tPgsYwVingVermWCfq7ugC4hHumUUCrd1iOl0FGF/qCALv50TNV+hWpN0
waTBi3uqN2NF3TlnLP9N5xwS4i/1bKz0r9OHH94ZMYCpwOi9AkEA94Vtw19EcJyZ
zFTXNS0F1U9lFA2YH/gp5/bPtjuo0wTSzrdcTV+D3QPj9gA1x7PLrov3J9t1rtLL
a1Iccyt+EwJBANpS8PAtwg3N5lfeNLHylEcNa1oUo+F0H5ZI782NQ5Mkvblw+f0R
9VbomMVyzAesbonZjWxYVpJolrKsJ2JBXe8CQQD0Wjqj1xa/fTmvqEnUayAJFxoY
E9uMI/dq0hL4OilOOMLL4+QxVgvdUovnPQnanjqDlBVouZSSA/NhfWwsnlEVAkBa
On8C9BZH+DljRR1IEbYAK2abgv47te88AAbDT8eGr1+NnUhjs6FOerBwocH6xeOl
KvkMtvGIbpshWo6oR9WXAkA6ynW4KgT+LK46oPzTMk800L9urfXxqfkG7e1RbBfu
RB/8wse2EH9H9UZC3nGRero7u5R4TF8QAznTbylUOp3N
-----END RSA PRIVATE KEY-----
EOT

  certificate = <<EOT
-----BEGIN CERTIFICATE-----
MIICTTCCAbYCCQC51kNm5eV2vzANBgkqhkiG9w0BAQsFADBrMQswCQYDVQQGEwJD
TjEOMAwGA1UECAwFbXlrZXkxDjAMBgNVBAcMBW15a2V5MQ4wDAYDVQQKDAVteWtl
eTEOMAwGA1UECwwFbXlrZXkxHDAaBgNVBAMME215a2NhcGl1c3IudGVzdC5jb20w
HhcNMjMwNjIxMDc1NzIzWhcNMzMwNjE4MDc1NzIzWjBrMQswCQYDVQQGEwJDTjEO
MAwGA1UECAwFbXlrZXkxDjAMBgNVBAcMBW15a2V5MQ4wDAYDVQQKDAVteWtleTEO
MAwGA1UECwwFbXlrZXkxHDAaBgNVBAMME215a2NhcGl1c3IudGVzdC5jb20wgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANMX0SrX8PEMR82Hc03gpheU7eUl+dM9
8rVOth4nolGRMtNpcR3hqSdCuvdWmROAxY37mlNmoirtVeC2dfugLDlfxkWRljjX
5rYzHS3GgtfV1u/OY3YwKGzB6o+/7TczXNC2sfT1g3rR1pR2SrpkWF0sNHR3DoHD
7DLg25mbOpq9AgMBAAEwDQYJKoZIhvcNAQELBQADgYEASzVpPb7TyQ+ephxr5D4e
mHzaiuTihYW5werfZUPPDmnLjytjVcgl1bU4rgZ71Q1VzNDWh6mGwvdrhCj2Ru0I
L02xonzbsqX9DTbVBJ5on5cjQV0kFspH4/nvlZyKs+Cl6jxK+z98kLGlLdU0d+kh
IckJ3NOY74WAmT4/n5+VuIw=
-----END CERTIFICATE-----
EOT
}

#创建ELB
resource "huaweicloud_elb_loadbalancer" "default" {
  name            = var.elb_loadbalancer_name
  description     = "Created by terraform"
  vpc_id          = huaweicloud_vpc.vpc_1.id
  ipv4_subnet_id  = huaweicloud_vpc_subnet.subnet_1.ipv4_subnet_id
  ipv6_network_id = huaweicloud_vpc_subnet.subnet_1.id
  l7_flavor_id = data.huaweicloud_elb_flavors.flavors.ids[0]
  l4_flavor_id = data.huaweicloud_elb_flavors.flavors_4.ids[0]
  availability_zone = [
    "ap-southeast-1c",
  ]
  ipv4_eip_id = huaweicloud_vpc_eip.dedicated_elb.id
  tags = {
    owner = "terraform"
  }
}
#添加7监听器
resource "huaweicloud_elb_listener" "default_7" {
  name            = var.elb_listener_name_7
  description     = "Created by terraform"
  protocol        = "HTTPS"
  protocol_port   = 443
  loadbalancer_id = huaweicloud_elb_loadbalancer.default.id
  http2_enable = true
  server_certificate = huaweicloud_elb_certificate.certificate_1.id
  tls_ciphers_policy = "tls-1-0-with-1-3"
  idle_timeout     = 60
  request_timeout  = 60
  response_timeout = 60

  tags = {
    owner = "terraform"
  }
}
#添加4监听器
resource "huaweicloud_elb_listener" "default_4" {
  name            = var.elb_listener_name_4
  description     = "Created by terraform"
  protocol        = "TCP"
  protocol_port   = 8000
  loadbalancer_id = huaweicloud_elb_loadbalancer.default.id

  idle_timeout     = 60
  request_timeout  = 60
  response_timeout = 60

  tags = {
    owner = "terraform"
  }
}

#负载方式
resource "huaweicloud_elb_pool" "default_7" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = huaweicloud_elb_listener.default_7.id

  persistence {
    type = "HTTP_COOKIE"
  }
}

resource "huaweicloud_elb_pool" "default_4" {
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = huaweicloud_elb_listener.default_4.id

  persistence {
    type = "HTTP_COOKIE"
  }
}
#后端服务器组
resource "huaweicloud_elb_monitor" "default_7" {
  protocol    = "TCP"
  interval    = 20
  timeout     = 15
  max_retries = 10
  port        = 80
  pool_id     = huaweicloud_elb_pool.default_7.id
}

resource "huaweicloud_elb_monitor" "default_4" {
  protocol    = "TCP"
  interval    = 20
  timeout     = 15
  max_retries = 10
  port        = 8000
  pool_id     = huaweicloud_elb_pool.default_4.id
}
#绑定机器
resource "huaweicloud_elb_member" "default_7" {
  address       = huaweicloud_compute_instance.basic[0].access_ip_v4
  protocol_port = 80
  pool_id       = huaweicloud_elb_pool.default_7.id
  subnet_id     = huaweicloud_vpc_subnet.subnet_1.ipv4_subnet_id
}

resource "huaweicloud_elb_member" "default_4" {
  address       = huaweicloud_compute_instance.basic[0].access_ip_v4
  protocol_port = 8000
  pool_id       = huaweicloud_elb_pool.default_4.id
  subnet_id     = huaweicloud_vpc_subnet.subnet_1.ipv4_subnet_id
}
