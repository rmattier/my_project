# Syndication-2.0 rabbitMQ Nodes [ Using Terraform ]
Notes:
* rabbitmq is configured to build out 3 node rabbitMQ cluster with static IPs.
* The static IPs, flavors, and images are defined in the variables.tf file and should be checked if they are current.
*

usage:
```sh
$ ./rabbitmq.sh -e <my-environment> -u <openstack user> [ -t <project/tenant name> ] [ -c <cell_id> ]
```
To display help
```sh
$ ./rabbitmq.sh -h
```

# To Destroy
```sh
$ ./rabbitmq.sh -e <my-environment> -u <openstack user> -t <project/tenant name> -d
```
The -d will notify terraform to issue a destroy instead of apply.

Within the directory the rabbitmq.sh file resides, you will notice the following directories.  When the terraform apply is successful, the state files should reside in there:
* c1
* qa
* stage
* dr
* prod
* (s1load)
