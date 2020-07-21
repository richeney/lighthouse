#!/bin/bash
##########################################################
# Simple version to work in Cloud Shell
##########################################################

az account set --subscription 266282c7-e082-4d48-a6df-56230652be28

echo "az account show"
az account show --output jsonc

echo "uri=https://raw.githubusercontent.com/richeney/lighthouse/master/azurecitadel.managedservicedefinition.json"
uri=https://raw.githubusercontent.com/richeney/lighthouse/master/azurecitadel.managedservicedefinition.json

echo "az deployment sub create --name lighthouse --template-uri $uri --location westeurope"
az deployment sub create --name lighthouse --template-uri $uri --location westeurope
