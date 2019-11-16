#!/bin/bash

cd ~/lighthouse
source ~/.git-prompt.sh

source ~/demo-magic.sh
export DEMO_PROMPT='\[\033[01;32m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[01;37m\]\$ '
export TYPE_SPEED=40
export NO_WAIT=true
export PROMPT_TIMEOUT=1

pe 'az account set --subscription 2d31be49-d959-4415-bb65-8aec2c90ba62'
pe 'az account show'
export PROMPT_TIMEOUT=0
pe 'jq . < ~/lighthouse/definition.json'
pe 'jq . < ~/lighthouse/definition.parameters.json'

pe 'az deployment create --name lighthouse --template-file definition.json --parameters "@definition.parameters.json"'
