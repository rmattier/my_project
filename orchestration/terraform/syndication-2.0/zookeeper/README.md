# Syndication-2.0 Zookeeper Nodes [ Using Terraform ]
Notes:
* Terraform is configured to build out 3 node zookeeper cluster.
* The flavor and images are predefined in the variables.tf file and should be checked if they are current.
* Very important to confirm the terraform keypair(s) are imported into openstack prior to the deployments.
* The keypairs need to be imported into the user running the deployment.
* 
usage:
```sh
$ ./zookeeper.sh -e <my-environment> -u <openstack user> -t <project/tenant name>
```
To display help
```sh
$ ./zookeeper.sh -h
```
Which will display:
Usage: ./zookeeper.sh [options]
-h this menu
-e environment
-u <username> (will prompt to enter password)
-t <tenant name> default is Syndication
-d destroy instances instead (default is apply/create)

# To Destroy
```sh
$ ./zookeeper.sh -e <my-environment> -u <openstack user> -t <project/tenant name> -d
```
The -d will notify terraform to issue a destroy instead of apply. 

Within the directory the zookeeper.sh file resides, you will notice the following directories.  When the terraform apply is successful, the state files should reside in there:
* c1
* qa
* stage
* dr
* prod
* (s1load)


