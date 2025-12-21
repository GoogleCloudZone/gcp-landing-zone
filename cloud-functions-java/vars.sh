#!/bin/bash
#
#export PROJECT_NAME=functions-old
export REGION=northamerica-northeast1
export SUPER_ADMIN_EMAIL=michael@obrienlabs.xyz
export PROJECT_LABELS="environment=sandbox,cicd=bash,owner=michael.obrien"
export STREAM_PROJECT_NAME_PREFIX=cloud-functions-arch-olx
# archetypes-gcp-cloud-olx
export ROOT_FOLDER_ID=579268326076

export HTTP_FUNCTION_NAME=ptlm
# must match src/main/java/jcfv2 package with class after
export JAVA_FQ_CLASSNAME=gcfv2.PeriodicTableLMHttpFunction

# on boot project run the following enablements
