# Define the terraform provider below.
provider "openstack" {
  user_name   = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password    = "${var.password}"
  auth_url    = "${lookup(var.auth_url, var.environment)}"
}

# We are creating multiple instances based on count.
resource "openstack_compute_instance_v2" "zookeeper" {
  count       = "${var.instance_count}"
  name        = "${lookup(var.hostname_prefix, var.environment)}${count.index + 4}"
  image_name  = "${var.image_name}"
  flavor_name = "${var.flavor_name}"
  key_pair    = "${lookup(var.key_pair, var.environment)}"
  region      = "${var.region_name}"

  network {
    name = "${lookup(var.network_name, var.environment)}"
  }
}
