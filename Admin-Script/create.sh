#!/bin/bash



# Name of the project to be created. Note this is used as the "namespace" for some objects/bindings below.
export PROJECT=Your_Project_Name

# Unique region for your cluster
export REGION=Your_Region_Name

# Unique namespace used
export SV_NAMESPACE_CLASS=Your_Namespace_Class_Name

# Your user id
export CCI_USER=Your_User_Name

# Name of the storage class. Note that most SV clusters are created with wcpglobal_storage_profile but gets
# converted to DNS compliant 'wcpglobal-storage-profile'
export STORAGE_CLASS=Your_storge_class_name

# Name of the Environment Selector
export ENVIRONMENT=Your_Env_Name

# Make sure you are logged in before executing this script
# kubectl ccs login -s  api_server_fqdn  -t  ORG_API_TOKEN  --skip-set-context --insecure-skip-tls-verify

# Created by an admin to group users and set access to infrastructure resources. 
envsubst < project.yaml | kubectl --context ccs create -f -

# Created by an admin to assign a role per user. CCS will validate one resource per user.
envsubst < projectrolebinding.yaml | kubectl --context ccs create -f -

# Created by an admin to group one or many supervisors in a region.
envsubst < region.yaml | kubectl --context ccs create -f -

# The admin will be able to update the Supervisor adding the region and with labels that will be used for namespace placement
# TBD Write some sed script to automate this
echo "Be sure to Patch Supervisor - Region / Labels per documentation"
echo "---------------------------------------------------------------"
echo "STEP 1 : Get list of supervisors :  kubectl -n ccs-config get supervisors"
echo "STEP 2 : Edit the superisor to add Region and Labels :  kubectl -n ccs-config edit supervisor <Supervisor Name>"
echo "Use this Label: "${ENVIRONMEN}
echo "Use this region: "${REGION}

# Created by an admin to define namespace templates with optional parameters. The resource should not contain any namespace settings.
envsubst < supervisornamespaceclass.yaml | kubectl create --context ccs -f -

# Created by an admin to define namespace class configuration with namespace settings. Parameter values can be used in namespace settings. 
envsubst < supervisornamespaceclassconfig.yaml | kubectl create --context ccs -f -

# Created by an admin to allow project accessing supervisors in a region. The resource should not contain any Supervisors placement settings.
envsubst < regionbinding.yaml | kubectl --context ccs create -f -

# Create or edit a Supervisor Namespace Class Config with additional expressions to match the Supervisor tags.
envsubst < regionbindingconfig.yaml | kubectl --context ccs create -f -

# Created by an admin to allow creating a Supervisor Namespace using the Supervisor Namespace Class in a project.
envsubst < supervisornamespaceclassbinding.yaml | kubectl create --context ccs -f -


