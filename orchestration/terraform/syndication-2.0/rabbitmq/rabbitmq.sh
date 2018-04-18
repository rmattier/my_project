#!/bin/bash

# The below shebang is based on macOS running bash 4.x.

# Variables
ENV_LIST="qa stage dr prod"
ENVIRONMENT=""
TENANT_NAME="Syndication"
CELL_ID_RE="[cd]"
CELL_ID=""
DESTROY="false"


usage() {
  echo "Usage: $0 [options]"
  echo "-h this menu"
  echo "-e environment"
  echo "-c cell ID (if not QA)"
  echo "-u <username> (will prompt to enter password)"
  echo "-t <tenant name> default is ${TENANT_NAME}"
  echo "-d destroy instances instead (default is apply/create)"
  exit 0
}

# This function checks all the required values have been entered.  If not,
# the usage will be displayed, and exits the script.
syntax_check() {
    # Make sure the ENVIRONMENT has the value of the allowed environments.
    local env_flag

    for e_check in ${ENV_LIST}
    do
      [[ $ENVIRONMENT == $e_check ]] && echo "You chose enviroment: ${ENVIRONMENT}"; _ENVIRONMENT=$ENVIRONMENT
    done

    [[ -z $_ENVIRONMENT ]] && echo "ERROR: Environment cannot be blank." && usage && exit 1

    ## If env is NOT qa, we need to pass the cell ID - only 'c' or 'd' as of 3/28/18
    if [[ $_ENVIRONMENT != "qa" ]] && [[ $CELL_ID =~ $CELL_ID_RE ]]
    then
      echo "You chose Cell: ${CELL_ID}"
      _CELL_ID=$CELL_ID
    else
      echo "ERROR: For environments other than QA, you must choose a cell"
      exit 1
    fi

    # Ensure a username was passed in
    [[ -z $USERNAME ]] && echo "ERROR: Username cannot be blank" && exit 1

}

while getopts ":c:e:ht:u:d" arg; do
  case $arg in
     c)
        CELL_ID=${OPTARG}
        ;;
     e)
        # For easier manipulation turn the argument lowercase
        ENVIRONMENT=${OPTARG}

#        if [[ ! "${ENVIRONMENT}" = "qa" ]]  &&  [[ ! "${ENVIRONMENT}" = "stage" ]] && [[ ! "${ENVIRONMENT}" = "dr" ]] && [[ ! "${ENVIRONMENT}" = "prod" ]]
#        then
#             echo "The environment does not match any of the following"
#             echo "qa stage dr prod"
#             exit 0
#        fi
        ;;
     t)
         # We can specify a tenant/project here.  The default is usually Syndication, but check the TENANT_NAME variable
         # In this script.
         TENANT_NAME=${OPTARG}
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

# Check syntax to ensure we have everything we need
syntax_check

# Run terraform based on the arguments given
echo "************************************************************"
echo "* Environment:  ${_ENVIRONMENT}"
echo "* Cell:         ${_CELL_ID}"
echo "* Tenant:       ${TENANT_NAME}"
echo "* Username:     ${USERNAME}"
echo "************************************************************"
echo ""


# Check to see if the terraform binary exists.
TERRAFORM_BIN=`which terraform`

if [ -x "$(which terraform)" ]
then
  echo "Terraform path --> ${TERRAFORM_BIN}"
  if [ "${DESTROY}" == "false" ]
  then
    ${TERRAFORM_BIN} apply --var "environment=${_ENVIRONMENT}" --var "cell_id=${_CELL_ID}" --var "user_name=${USERNAME}" --var "tenant_name=${TENANT_NAME}"  --var "password=${PASSWORD}" -state="${ENVIRONMENT}/terraform.tfstate"
  elif [ "${DESTROY}" == "true" ]
  then
    ${TERRAFORM_BIN} destroy --var "environment=${_ENVIRONMENT}" --var "cell_id=${_CELL_ID}" --var "user_name=${USERNAME}" --var "tenant_name=${TENANT_NAME}"  --var "password=${PASSWORD}" -state="${ENVIRONMENT}/terraform.tfstate"
  fi
else
  echo "terraform executable does not exist in path."
  exit 1
fi
