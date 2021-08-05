#!/bin/bash
##########################################################
# Simple version to work in Cloud Shell
##########################################################

echo "az account show"
az account show --output jsonc

uri=https://raw.githubusercontent.com/richeney/lighthouse/master/azurecitadel.json

echo "uri=$uri"
echo "az deployment sub create --name lighthouse --template-uri $uri --location westeurope"
az deployment sub create --name lighthouse --template-uri $uri --location westeurope
