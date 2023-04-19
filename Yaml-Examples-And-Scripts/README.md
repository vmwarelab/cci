
## Cloud Consumption Interface powered by Aria Automation

## Details on the Script files

## AllowAllPods.sh
For TKG Clusters to create an allow all Pod Security Policy
This shouldn't be done in production, but for a quick start, this will bind all authenticated users to run any type of container:

## auto-complete.sh
Enable kubectl bash completion and fast context switching

## connect-cci-admin.sh  
Populate the script with your Admin API Token and AA SaaS API Server when connecting to CCI using the plugin

## connect-cci-user.sh  
Populate the script with your User API Token and AA SaaS API Server when connecting to CCI using the Kubectl CCI plugin

```
API Servers List
================
United States    api.mgmt.cloud.vmware.com
United Kingdom   uk.api.mgmt.cloud.vmware.com
Japan            jp.api.mgmt.cloud.vmware.com
Singapore        sg.api.mgmt.cloud.vmware.com
Germany          de.api.mgmt.cloud.vmware.com
Australia        au.api.mgmt.cloud.vmware.com
Canada           ca.api.mgmt.cloud.vmware.com
Brazil           br.api.mgmt.cloud.vmware.com
```
## connect-sc.sh
Populate the script with your Supervisor IP , username and password to connect to the supervisor cluster using the kubectl vsphere plug-ing 

## connect-tkg-cluster.sh
Populate the script with your Supervisor IP , Supervisor Namespace, TKG Cluster name, username and password to connect to the TKG cluster using the kubectl vsphere plug-ing 


`Note:`
- The Yaml Files should be self explanatory
- Make sure the scripts are executable

## Details on the Yaml files Examples

## project.yaml
Populate the yaml file to create a project.

## projectrolebinding.yaml
Populate the yaml file to create to add a user to a project

## pvc.yaml
Populate the yaml file to create a PersistentVolumeClaim

## redis1-vm-service.yaml
Example to provision a vm, vm service and secret to pass user-data to the vm

## redis2-vm-service.yaml
Example to provision a vm, vm service and secret to pass user-data to the vm ( Just another redis vm)

## region.yaml
Populate the yaml file to create a region.

## regionbinding.yaml
Populate the yaml file to map a project to a region.

## regionbindingconfig.yaml
Populate the yaml file to configure the placement for above regionbinding.

## supervisornamespace.yaml
Populate the yaml file to provision a supervisor name space

## supervisornamespaceclass.yaml
Populate the yaml file to create a supervisornamespace class aka Template

## supervisornamespaceclassconfig.yaml
Populate the yaml file to configure a supervisornamespace class aka Template

## supervisornamespacebinding.yaml
Populate the yaml file to map the supervisornamespace class to a project. 

## tkc-1-alpha1.yaml
Example to provision a tkg cluster using alpha1 api

## tkc-1-alpha2.yaml
Example to provision a tkg cluster using alpha2 api which is more recent
