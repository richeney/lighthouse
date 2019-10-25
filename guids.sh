#!/bin/bash

source ~/.git-prompt.sh

source ~/demo-magic.sh
export DEMO_PROMPT='\[\033[01;32m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[01;37m\]\$ '
export TYPE_SPEED=40
export NO_WAIT=true
export PROMPT_TIMEOUT=1

# pe 'az account set --subscription 2d31be49-d959-4415-bb65-8aec2c90ba62'
pe 'az account show'

pe 'az ad user show --id richeney@microsoft.com --query objectId --output tsv'
pe 'az role definition list --query "[?roleName =='\''Contributor'\''].name" --output tsv'

pe 'az ad group show --group "UK OCP CSA Team" --query objectId --output tsv'
pe 'az role definition list --query "[?roleName == '\''Reader'\''].name" --output tsv'

pe 'az ad sp show --id http://billingreader --query appId --output tsv'
pe 'az role definition list --query "[?roleName == '\''Billing Reader'\''].name" --output tsv'
