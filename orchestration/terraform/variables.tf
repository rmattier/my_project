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
    "s1load" = "http://stage-openstackapi.ad.prodcc.net:5000/v2.0/"
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
    "s1load" = "net616"
    "dr"    = "net700"
    "prod"  = "net708"
  }
}

variable "subnet_name" {
  type = "map"

  default = {
    qa    = "17de0b35-4afa-4b02-bc5d-bf8691c45e8f"
    stage = "418b2696-811e-4523-8e12-f4a421dd29f4"
    s1load = "418b2696-811e-4523-8e12-f4a421dd29f4"
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
  #default = "zookeeper.txt"
}

variable "image_name" {
  default = "centos7-base_5.latest"
}

variable "flavor_name" {
  default = "m1.medium"
}

variable "puppetmasters" {
  type = "map"

  default = {
    qa    = "p2-qapuppet2.ad.prodcc.net"
    stage = "p2-puppets2.ad.prodcc.net"
    s1load = "p2-puppets2.ad.prodcc.net"
    prod  = "p2-puppet2.ad.prodcc.net"
    dr    = "sca1-puppet502.ad.prodcc.net"
  }
}

variable "hostname_prefix" {
  type = "map"

  default = {
    qa    = "p2-qa-zk-syndication-00"
    #stage = "p2-s1-zk-syndication-00"
    stage = "p2-s1-zk-syndication-00"
    s1load = "p2-s1-zk-synload-00"
    dr    = "sca1-dr-zk-syndication-00"
    prod  = "p2-prod-zk-syndication-00"
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
    #qa    = "~/.ssh/qa-terraform.pub"
    qa    = "~/.ssh/qa-test-terraform.pem"
    stage = "~/.ssh/stage-terraform"
    s1load = "~/.ssh/stage-terraform"
    #dr    = "~/.ssh/dr-terraform"
    #dr    = "~/.ssh/prod-terraform"
    prod  = "~/.ssh/prod-terraform"
    dr  = "~/.ssh/test-terraform.pem"
  }
}

### Zookeeper specific variables.
variable "cluster_name" {
  #default = "syndication"
  default = "syndload"
}

variable "cluster_size" {
  default = 3
}

variable "key_pair" {
  type = "map"
  default = {
    #qa    = "qa-terraform"
    qa    = "qa-test-terraform"
    stage = "stage-terraform"
    s1load = "stage-terraform"
    #dr    = "prod-terraform"
    dr    = "test-terraform"
    prod  = "prod-terraform"
  }
}
