#!/bin/bash

cd ~/lighthouse
source ~/.git-prompt.sh

source ~/demo-magic.sh
export DEMO_PROMPT='\[\033[01;32m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[01;37m\]\$ '
export TYPE_SPEED=40
export NO_WAIT=true
export PROMPT_TIMEOUT=1

pe 'az account set --subscription 266282c7-e082-4d48-a6df-56230652be28'
pe 'az account show'
pe 'uri=https://raw.githubusercontent.com/richeney/lighthouse/master/azurecitadel.managedservicedefinition.json'
export PROMPT_TIMEOUT=0
pe 'curl -sSL $uri | jq .'
pe 'az deployment create --name lighthouse --template-uri $uri --location westeurope'
