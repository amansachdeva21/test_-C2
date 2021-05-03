#!/bin/bash
#set -x

bold="\e[1m"
reset="\e[0m"
red="\e[31m"
green="\e[42m"
blue="\e[34m"
purple="\e[35m"

success() {
  printf "${bold}${green}Success!${reset} ${green}%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
error() {
   printf "${red}${bold}✖ %s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
   exit 1
}
note() {
   printf "\n${bold}${blue}Note:${reset} ${blue}%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}

function usage()
{
   echo o "Usage: $0 "Instance-name" "Project" "Zone" should be passed"
   exit 1
}

if [ $# -lt 3 ] ; then
    usage;
    exit 0;
fi;

####################################################
##### function to get the metadata of instance #####
####################################################
function getMetadataKey()
{
    note "details will be fetched for $instancename instance from $project project"
    gcloud auth activate-service-account --key-file=./account.json
    export GOOGLE_APPLICATION_CREDENTIALS=./account.json
    if [ -z $key ]
    then
      value="$(gcloud compute instances describe $instancename --project=$project --format json --zone=$zone --format='value[](metadata.items)')" || error "ERROR ==>> !!! Error - required information is not correct or the resource does not exit !!!"
      echo $value
      success "Successfully fetched all the keys and values!!!"
    else
      note "Fetinng the result for $key key"
      value="$(gcloud compute instances describe $instancename --project=$project --zone=$zone --format='value[](metadata.items.'$key')')" || error "ERROR ==>> !!! Error - required information is not correct or the resource does not exit !!!"
      if [ -z $value ]
      then 
        printf "Key is not present in metadata.\n"
      else 
        printf '{"'${key}'":"%s"}\n' "$value"
	success "Successfully fetched all the keys and values!!!"
      fi
    fi
}

instancename=$1
project=$2
zone=$3
key=$4

getMetadataKey
