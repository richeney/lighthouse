#!/bin/bash

if [[ "richeney@azurecitadel.com" != "$(az ad signed-in-user show --query userPrincipalName --output tsv)" ]]
then
  az logout 2>/dev/null
  echo "Logging in as richeney@azurecitadel.com"
  az login --username richeney@azurecitadel.com --tenant azurecitadel.onmicrosoft.com
fi

set -x

az account set --subscription 2d31be49-d959-4415-bb65-8aec2c90ba62
az account show

az extension add --name managementpartner
az managementpartner show
az managementpartner create --partner-id 4827146
az managementpartner delete --partner-id 4827146

