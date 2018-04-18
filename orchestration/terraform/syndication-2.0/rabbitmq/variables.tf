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

### End provider variables.

variable "network_name" {
  type = "map"

  default = {
    "qa"    = "net600"
    "stage" = "net610"
    "dr"    = "net700"
    "prod"  = "net700"
  }
}

variable "subnet_name" {
  type = "map"

  default = {
    "qa"    = "net600-subnet"
    "stage" = "net610-subnet"
    "dr"    = "net700-subnet"
    "prod"  = "net700-subnet"
  }
}

### Variables for provisioning the server(s)
variable "instance_count" {
  default = 3
}

variable "cell_id" {
  default = ""
}

variable "static_ips" {
  type = "map"
  default = {
    "stage_d"   =  "172.16.107.221, 172.16.107.222, 172.16.107.223"
    "prod_d"    =  "10.24.3.245, 10.24.3.246, 10.24.3.247"
  }
}



# As of 3/27/18 rabbitMQ is only supported on centos6
variable "image_name" {
  default = "centos69-base-5.4.2"
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
    qa    = "p2-qa-rmq-syn-"
    stage = "p2-s1-rmq-syn-"
    dr    = "sca1-dr-rmq-syn-"
    prod  = "p2-prod-rmq-syn-"
  }
}

### Connection variables. Make sure the keyfiles have been added to openstack first.
variable "ssh_user_name" {
  default = "root"
}


### NOTE ###
# I think keypairs are only needed if we want terraform to connect to instances via SSH to run puppet
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

variable "key_pair" {
  type = "map"
  default = {
    qa    = "qa-terraform"
    stage = "stage-terraform"
    dr    = "prod-terraform"
    prod  = "prod-terraform"
  }

}
