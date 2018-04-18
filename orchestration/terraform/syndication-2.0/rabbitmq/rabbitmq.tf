# Define the terraform provider below.
provider "openstack" {
  user_name   = "${var.user_name}"
  tenant_name = "${var.tenant_name}"
  password    = "${var.password}"
  auth_url    = "${lookup(var.auth_url, var.environment)}"
}

data "openstack_networking_network_v2" "network" {
  name = "${lookup(var.network_name, var.environment)}"
}

data "openstack_networking_subnet_v2" "subnet" {
  name = "${lookup(var.subnet_name, var.environment)}"
}

# Create Neutron ports with Fixed IPs to minimize LB work
resource "openstack_networking_port_v2" "port" {
  count       = "${var.instance_count}"
  network_id     = "${data.openstack_networking_network_v2.network.id}"
  admin_state_up = "true"
  fixed_ip {
    subnet_id = "${data.openstack_networking_subnet_v2.subnet.id}"
    ip_address = "${trimspace(element(split(",",lookup(var.static_ips, format("%s_%s",var.environment,var.cell_id))),count.index))}"
  }
}

# We are creating multiple instances based on count.
resource "openstack_compute_instance_v2" "rabbitmq" {
  count       = "${var.instance_count}"
  name        = "${lookup(var.hostname_prefix, var.environment)}${var.cell_id}${format("%03d",count.index + 1) }"
  image_name  = "${var.image_name}"
  flavor_name = "${var.flavor_name}"
  region      = "${var.region_name}"

  network {
     port  = "${element(openstack_networking_port_v2.port.*.id, count.index)}"
  }
}
