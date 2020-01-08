#!/bin/bash

signedInUser=richeney@azurecitadel.com
uri=https://raw.githubusercontent.com/richeney/lighthouse/master/azurecitadel.managedservicedefinition.json

if [[ "$signedInUser" != "$(az ad signed-in-user show --query userPrincipalName --output tsv)" ]]
then
  az logout 2>/dev/null
  echo "Logging in as $signedInUser"
  az login --username $signedInUser
fi

set -x

az ad user show --id $signedInUser --query objectId --output jsonc
az role definition list --query "[?roleName =='Contributor']|[0].name" --output jsonc

az ad group show --group "Virtual Machine Admins" --query objectId --output jsonc
az role definition list --query "[?roleName == 'Virtual Machine Contributor']|[0].name" --output jsonc

az ad sp show --id http://billingreader --query objectId --output jsonc
az role definition list --query "[?roleName == 'Billing Reader']|[0].name" --output jsonc

curl -H 'Cache-Control: no-cache' -sSL $uri | jq .variables.authorizations
