#!/usr/local/bin/bash

# The below shebang is based on macOS running bash 4.x.

# Variables
ENV_LIST="qa stage s1load dr prod"
SERVERNAME=""
ENVIRONMENT=""
ENSEMBLE_NUMBER=""
TENANT_NAME="Syndication"
DESTROY="false"


usage() {
  echo "Usage: $0 [options]"
  echo "-h this menu"
  echo "-e environment"
  #echo "-s <servername>"
  echo "-u <username> (will prompt to enter password)"
  echo "-t <tenant name> default is ${TENANT_NAME}"
  echo "-d destroy instances instead (default is apply/create)"
  exit 0
}

getEnsemblePlacement() {
  #echo "Ensemble Placement"
   local ENSEMBLE_NUMBER="${SERVERNAME: -1}"
   echo "${ENSEMBLE_NUMBER}"
}

# This function checks all the required values have been entered.  If not,
# the usage will be displayed, and exits the script.
syntax_check() {
    # Make sure the ENVIRONMENT has the value of the allowed environments.
    local env_flag

    for e_check in ${ENV_LIST}
    do
        if [ "${ENVIRONMENT}" == "${e_check}"]
        then
          echo "You enviroment chosen is: ${ENVIRONMENT}"
          break
        fi
    done

     if [ -x "${SERVERNAME}" ]
     then
         echo "Server name cannot be empty."
         exit 0
     fi

     if [ -x "$USERNAME" ]
     then
        echo "Username cannot be blank"
        exit 0
     fi
}

while getopts ":e:ht:u:d" arg; do
  case $arg in
     e)
        # Foe easier manipulation turn the argument lowercase
        #ENVS=${OPTARG}
        ENVIRONMENT=${OPTARG,,}

        #if [ "${ENVIRONMENT}" != "qa" ] || [ ${ENVIRONMENT} != "stage" ] || [ ${ENVIRONMENT} != "dr" ]  || [ "${ENVIRONMENT}" != "prod" ] || [ "${ENVIRONMENT}" != "s1load" ]
        if [[ ! "${ENVIRONMENT}" = "qa" ]]  &&  [[ ! "${ENVIRONMENT}" = "stage" ]] && [[ ! "${ENVIRONMENT}" = "dr" ]] && [[ ! "${ENVIRONMENT}" = "prod" ]] && [[ ! "${ENVIRONMENT}" = "s1load" ]]
        then
             echo "The environment does not match any of the following"
             echo "qa stage s1load dr prod"
             exit 0
        fi
        ;;
        s)
              # We have a server name
        # To make sure case is no issue, we change the arguments to all lowercase.
        SERVERNAME=${OPTARG,,}

        if [ -z ${SERVERNAME} ]
        then
          echo "Server Name cannot be empty"
          usage
        fi
        ;;
     t)
         # We can specify a tenant/project here.  The default is usually Syndication, but check the TENANT_NAME variable
         # In this script.
         TENANT_NAME=${OPTARG,,}
         ;;
     u)
         # User that will commit the changes to openstack
         # Then issue a password to run the commands
         # The password does not echo back to stdout.
         USERNAME=${OPTARG}
         echo "Hello, username ${USERNAME} please enter you password:"
         read -s PASSWORD
         ;;
      d)
         # If this flag is invoked, prepare to destroy with the same parameters.
         DESTROY="true"
         ;;
     *)
        usage
        ;;
  esac
done

# The 'e' represents environment (qa,stage,dr,prod)
# The 's' represents the server name.
# Run terraform based on the arguments given
my_numbers_1="$(getEnsemblePlacement)"
echo "************************************************************"
echo "* Hostname   ${SERVERNAME}                ** "
echo "* Environment ${ENVIRONMENT}              ** "
echo "* Tenant ${TENANT_NAME}                   ** "
echo "* Number ${my_numbers_1}                  **"
echo "* Username ${USERNAME}                            **"
echo "************************************************************"

# Now, based on the arguments we can execute terraform template to build
# a new instance.

# Before we execute the terraform command, we need to make sure we have a complete
# List of parameters.

#syntax_check

# Check to see if the terraform binary exists.
TERRAFORM_BIN=`which terraform`

if [ -x "$(which terraform)" ]
then
  echo "Terraform path --> ${TERRAFORM_BIN}"
  if [ "${DESTROY}" == "false" ]
  then
    ${TERRAFORM_BIN} apply --var "environment=${ENVIRONMENT}" --var "user_name=${USERNAME}" --var "tenant_name=${TENANT_NAME}"  --var "user_name=${USERNAME}" --var "password=${PASSWORD}" -state="${ENVIRONMENT}/terraform.tfstate"
    #${TERRAFORM_BIN} plan --var "environment=${ENVIRONMENT}" --var "user_name=${USERNAME}" --var "tenant_name=${TENANT_NAME}"  --var "user_name=${USERNAME}" --var "password=${PASSWORD}" -state="${ENVIRONMENT}/terraform.tfstate"
  elif [ "${DESTROY}" == "true" ]
  then
    ${TERRAFORM_BIN} destroy --var "environment=${ENVIRONMENT}" --var "user_name=${USERNAME}" --var "tenant_name=${TENANT_NAME}"  --var "user_name=${USERNAME}" --var "password=${PASSWORD}" -state="${ENVIRONMENT}/terraform.tfstate"
  fi
else
  echo "terraform executable does not exist in path."
  exit 0
fi
