
resource "null_resource" "run_puppet" {
  count       = "${var.cluster_size}"
  triggers {
    cluster_members = "${join(",", openstack_compute_instance_v2.zookeeper.*.access_ip_v4)}"
  }

  connection {
    host        = "${element(openstack_compute_instance_v2.zookeeper.*.access_ip_v4, count.index)}"
    user        = "${var.ssh_user_name}"
    private_key = "${file("${lookup(var.ssh_private_key,var.environment)}")}"

  }

  # Create fact file, with zookeeper ensemble information.
  provisioner "remote-exec" {
    inline = [ 
      "echo ensemble_servers=${join(",",openstack_compute_instance_v2.zookeeper.*.access_ip_v4)}   > ${var.facter_file}",
      "echo myid=${count.index + 1} >> ${var.facter_file}",
      "echo ensemble_id=${var.cluster_name} >> ${var.facter_file}"
    ]
  }

  provisioner "remote-exec" {
    inline = [ 
      "puppet agent --onetime --no-daemonize --no-usecacheonfailure --server=${lookup(var.puppetmasters,var.environment)} --environment=syndication2_infrastructure --no-noop",
       "puppet agent --onetime --no-daemonize --no-usecacheonfailure --server=${lookup(var.puppetmasters,var.environment)} --environment=syndication2_infrastructure --no-noop"
    ]
  }
}
