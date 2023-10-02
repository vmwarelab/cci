## Cloud Consumption Interface powered by Aria Automation

This script should be used alongside the instructions for connecting a cluster to vRA as documented in Documentation 


You need to follow the instructions to
* Deploy a vSphere testbed (or use an existing one)
* Deploy the Cloud Proxy
* Create the Cloud Account in vRA
* Make sure you have kubectl and the cci plugin installed

You can run the script `create.sh` after updating the variables in the file and logging in.

Edit these values in the script.

`PROJECT`: Name of the project in cci

`REGION`: Unique region name for the project

`SV_NAMESPACE_CLASS`: Name of the SV namespace class that will be created.

`cci_USER`: User that needs to be granted permission to operate on the namespace. 
This should be your LDAP user id.

`STORAGE_CLASS`: The name of the storage class that will be used. It needs to be available in the SV.

`ENVIRONMENT` : The  Name of the Environment Selector

Login
```
kubectl cci login -s  api_server_fqdn  -t  ORG_API_TOKEN  --skip-set-context --insecure-skip-tls-verify
```
Make sure you are in the cci context.
```
kubectl config use-context cci
```
Run the script
```
bash -v create.sh
```

You need to then edit the supervisor resource to assign it to the region created with a the environment label as below :

Find your SV cluster:
```
kubectl -n cci-config get supervisors
```

Then update it to add the label and region:

```
kubectl -n cci-config edit supervisor ${YOUR_SV_CLUSTER}
```

Add a label representing the supervisor in a key value pair formatn ( for Example environment: prod ):
```
  labels: 
    environment: ${matching the ${ENVIRONMENT} above}
```

Add this to the spec, matching the ${REGION} created above
```
  regionNames:
    - ${matching the ${REGION} above}
```

You should be able to login to the cci environment and see the project and be able to create namespaces.
