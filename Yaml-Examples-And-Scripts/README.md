
## Cloud Consumption Interface powered by Aria Automation

##Details on the Yaml and Script files 


## AllowAllPods.sh
For TKG Clusters to create an allow all Pod Security Policy
This shouldn't be done in production, but for a quick start, this will bind all authenticated users to run any type of container:

## auto-complete.sh
Enable kubectl bash completion and fast context switching

## connect-cci-admin.sh  
Populate the script with your Admin API Token and AA SaaS API Server when connecting to CCI using the plugin
```
United States    api.mgmt.cloud.vmware.com
United Kingdom   uk.api.mgmt.cloud.vmware.com
Japan            jp.api.mgmt.cloud.vmware.com
Singapore        sg.api.mgmt.cloud.vmware.com
Germany          de.api.mgmt.cloud.vmware.com
Australia        au.api.mgmt.cloud.vmware.com
Canada           ca.api.mgmt.cloud.vmware.com
Brazil           br.api.mgmt.cloud.vmware.com

## connect-cci-user.sh  
Populate the script with your User API Token and AA SaaS API Server when connecting to CCI using the Kubectl CCI plugin
```
United States    api.mgmt.cloud.vmware.com
United Kingdom   uk.api.mgmt.cloud.vmware.com
Japan            jp.api.mgmt.cloud.vmware.com
Singapore        sg.api.mgmt.cloud.vmware.com
Germany          de.api.mgmt.cloud.vmware.com
Australia        au.api.mgmt.cloud.vmware.com
Canada           ca.api.mgmt.cloud.vmware.com
Brazil           br.api.mgmt.cloud.vmware.com

## connect-sc.sh
Populate the script with your Supervisor IP , username and password to connect to the supervisor cluster using the kubectl vsphere plug-ing 

## connect-tks-1.sh
Populate the script with your Supervisor IP , Supervisor Namespace, TKG Cluster name, username and password to connect to the TKG cluster using the kubectl vsphere plug-ing 


Note: The Yaml Files should be self explanatory 