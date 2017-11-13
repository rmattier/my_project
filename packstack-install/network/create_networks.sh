#!/bin/bash 

# The below creates a network 
neutron net-create external_network --provider:network_type flat --provider:physical_network extnet  --router:external

Creates the public network and flaoting range.
neutron subnet-create --name public_subnet --enable_dhcp=False --allocation-pool=start=10.0.0.50,end=10.0.0.90 --gateway=10.0.0.1 external_network 10.0.0.0/24

# Add the cirros image for testing purposes...For now!
curl http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img | glance image-create --name='cirros image' --visibility=public --container-format=bare --disk-format=qcow2

# Create a user account, and a project and associate the user with the new project
openstack project create --enable infrastructure

openstacl user create --project infrastructure --password mypasswd --email rmattier@gmail.com --enable infrastructure 

# Now.  Create the router and networks
neutron router-create router1
neutron router-gateway-set router1 external_network

neutron net-create private_network
neutron subnet-create --name private_subnet_1 private_network 172.18.20.0/24
neutron subnet-create --name private_subnet_2 private_network 172.18.30.0/24
neutron subnet-create --name private_subnet_2 private_network 172.18.40.0/24

neutron router-interface-add router1 private_subnet_1
neutron router-interface-add router1 private_subnet_2
neutron router-interface-add router1 private_subnet_3
