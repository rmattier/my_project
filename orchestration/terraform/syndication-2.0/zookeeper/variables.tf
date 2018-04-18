### Provider Specific Variables.
variable "user_name" { }

variable "tenant_name" {
  default = "Syndication"
}

variable "password" { }
variable "environment" { }

variable "auth_url" {
  type = "map"

  default = {
    "qa"    = "http://qa-openstackapi.ad.prodcc.net:5000/v2.0/"
    "stage" = "http://stage-openstackapi.ad.prodcc.net:5000/v2.0/"
    "dr"    = "http://dr-openstackapi.ad.prodcc.net:5000/v2.0/"
    "prod"  = "http://prod-openstackapi.ad.prodcc.net:5000/v2.0/"
  }
}

variable "region_name" {
  default = "regionOne"
}

### End provider vaiables.

# Network specific based on current images and network configuration(s).
# CentOS 7.3 latest. 
variable "network_name" {
  type = "map"

  default = {
    "qa"    = "net600"
    "stage" = "net616"
    "dr"    = "net700"
    "prod"  = "net708"
  }
}

variable "subnet_name" {
  type = "map"

  default = {
    qa    = "17de0b35-4afa-4b02-bc5d-bf8691c45e8f"
    stage = "418b2696-811e-4523-8e12-f4a421dd29f4"
    dr    = "822b45a7-d8a7-4bfa-9dc2-ba86d7662d7d"
    prod  = "885c21d6-6073-4595-8fd4-1b5f5ee9901f"
  }
}
### Variables for provisioning the server(s)
variable "instance_count" {
  default = 3
}

variable "facter_file" {
  default = "/etc/facter/facts.d/zookeeper.txt"
}

# As of 11-02-2017 this is the latest centOS 7 used in openstack.
variable "image_name" {
  default = "centos7-base_5.latest"
}

# The current flavor used for zookeeper nodes across openstack environements.
variable "flavor_name" {
  default = "m1.medium"
}

variable "puppetmasters" {
  type = "map"

  default = {
    qa    = "p2-qapuppet2.ad.prodcc.net"
    stage = "p2-puppets2.ad.prodcc.net"
    prod  = "p2-puppet2.ad.prodcc.net"
    dr    = "sca1-puppet502.ad.prodcc.net"
  }
}

variable "hostname_prefix" {
  type = "map"

  default = {
    qa    = "p2-qa-zk-syndication-01"
    stage = "p2-s1-zk-syndication-01"
    dr    = "sca1-dr-zk-syndication-01"
    prod  = "p2-prod-zk-syndication-01"
  }
}

### Connection variables. Make sure the keyfiles have been added to openstack first.
variable "ssh_user_name" {
  default = "root"
}

# Make sure to have the actual keys downloaded and put in your local environment
variable "ssh_private_key" {
  type = "map"

  default = {
    qa    = "~/.ssh/qa-terraform.pub"
    stage = "~/.ssh/stage-terraform"
    prod  = "~/.ssh/prod-terraform"
    dr  = "~/.ssh/dr-terraform.pem"
  }
}

### Zookeeper specific variables.
variable "cluster_name" {
  default = "syndication"
}

variable "cluster_size" {
  default = 3
}

variable "key_pair" {
  type = "map"
  default = {
    qa    = "qa-terraform"
    stage = "stage-terraform"
    dr    = "prod-terraform"
    prod  = "prod-terraform"
  }
}
