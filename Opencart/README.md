## Instruction to deploy the MOAD Opencart Application

## 1. Login into CCI as an Admin or User using the K8s CCI plugin
```
export CCI_API_TOKEN=Your_Admin/User_Token
export SERVER=Your_API_Server
kubectl ccs login -t $CCI_API_TOKEN --server $SERVER --skip-set-context --insecure-skip-tls-verify
```
## 2. Switch Context to CCS
```
kubectl config use-context ccs
```
## 3. Create a Supervisor Namespace
```
kubectl create -f oc-svns.yaml
```
Template 
```
apiVersion: infrastructure.ccs.vmware.com/v1alpha1
kind: SupervisorNamespace
metadata:
  name: Your_Supervisor_Namespaces
  namespace: Your_Project_Name
spec:
  description: Your_Description
  regionName: Your_Region_Name
  className: Your_Supervisor_Namespace_Class_Name
  ```
## 3. Create your context 
```
  kubectl ccs set-context --project moad --supervisor-namespace open-cart
```
Note: You only have to create your context if you login with --skip-set-context option.
      Without it the conext will be auto created when you login into cci.

## 3. Switch Context to your Supervisor Name ccs:moad:open-cart
```
kubectl config use-context ccs:moad:open-cart
```

## 4. Deploy your MySQL Database using VM Service
```
kubectl create -f oc-mysql-vm.yaml
```
Note: This will create the MySQL VM and the MySQL VM Service

Document the MySQL Service assigned External IP -> 10.176.193.6

```
kubectl get vm,vmservice,service -o wide

NAME                                            POWERSTATE   CLASS               IMAGE                                PRIMARY-IP   AGE
virtualmachine.vmoperator.vmware.com/oc-mysql   poweredOn    best-effort-small   ubuntu-18.04-server-cloudimg-amd64                83s

NAME                                                              TYPE           AGE
virtualmachineservice.vmoperator.vmware.com/oc-mysql-vm-service   LoadBalancer   83s

NAME                          TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)                       AGE   SELECTOR
service/oc-mysql-vm-service   LoadBalancer   10.96.0.152   10.176.193.6   3306:30292/TCP,22:32217/TCP   83s   <none>
```
## 5. Deploy a TKG Cluster within the open-cart Supervisor Namespace
```
kubectl create -f oc-tkg-cluster.yaml
```

## 6. Login into your TKG Cluster using the K8s vSphere Plugin 
```
export SC_IP=Your_Supervisor_IP
export NAMESPACE=Your_Namespace
export KUBECTL_VSPHERE_PASSWORD=Your_vSphere_Password
kubectl vsphere login --server=https://$SC_IP --tanzu-kubernetes-cluster-name Your_TKG_Cluster_Name --tanzu-kubernetes-cluster-namespace $NAMESPACE --vsphere-username Your_vSphere_Username --insecure-skip-tls-verify
```

## 7. Switch Context to your TKG Cluster 
```
kubectl config use-context ccs:moad:open-cart
```
Note: You will be automatically switched to your TKG Cluster Contxt upon login.

## 8. Create an allow all Pod Security Policy
This shouldn't be done in production, but for a quick start, this will bind all authenticated users to run any type of container
```
kubectl create clusterrolebinding default-tkg-admin-privileged-binding --clusterrole=psp:vmware-system-privileged --group=system:authenticated
```

## 9. Deploy the Opencart Frontend using Helm packaged by Bitnami
https://bitnami.com/stack/opencart/helm

# A. Add the bitnami repo:
```
helm repo add bitnami https://charts.bitnami.com/bitnami
```
# B. Install the Opencart Helm chart with Custom options to disable the embedded Maria Database and specify our own parameters
for the Opencart username and password, the MySQL Database, the Database username and password and finally the database name. 
```
helm install --namespace default my-open-cart bitnami/opencart --set opencartUsername="demouser",opencartPassword="VMware1!",externalDatabase.host="10.176.193.6",externalDatabase.user="ocuser",externalDatabase.password="VMware1!",externalDatabase.database="opencart",mariadb.enabled="false"
```
Note: The External Database IP is from step 4, the IP address for the MySQL Service provisioned via the VM Service.

Follow the Helm chart insturctions ( Dont Copy anything out of this output )

```
1. Get the OpenCart URL by running:

  NOTE: It may take a few minutes for the LoadBalancer IP to be available.
        Watch the status with: 'kubectl get svc --namespace default -w my-open-cart-opencart'

  export APP_HOST=$(kubectl get svc --namespace default my-open-cart-opencart --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
  export APP_PASSWORD=$(kubectl get secret --namespace default my-open-cart-opencart -o jsonpath="{.data.opencart-password}" | base64 -d)
  export DATABASE_ROOT_PASSWORD=$(kubectl get secret --namespace default my-open-cart-opencart-externaldb -o jsonpath="{.data.mariadb-root-password}" | base64 -d)
  export APP_DATABASE_PASSWORD=$(kubectl get secret --namespace default my-open-cart-opencart-externaldb -o jsonpath="{.data.mariadb-password}" | base64 -d)

2. Complete your OpenCart deployment by running:

  ## PLEASE UPDATE THE EXTERNAL DATABASE CONNECTION PARAMETERS IN THE FOLLOWING COMMAND AS NEEDED ##

  helm upgrade --namespace default my-open-cart my-repo/opencart \
    --set opencartPassword=$APP_PASSWORD,opencartHost=$APP_HOST,service.type=LoadBalancer,mariadb.enabled=false,externalDatabase.host=10.176.193.6,externalDatabase.user=ocuser,externalDatabase.password=VMware1!,externalDatabase.database=opencart
 ```   

# C. Document the LoadBalancer IP  once its generated - > 10.176.193.17 by running 

```
kubectl get svc --namespace default  my-open-cart-opencart
NAME                    TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
my-open-cart-opencart   LoadBalancer   10.96.69.234   10.176.193.17   80:30049/TCP,443:32309/TCP   2m3s
```

Execute the above 4 Export commands to set the upgrade command variables being used

# D. Complete your OpenCart deployment by running the Helm upgarde

```
helm upgrade --namespace default my-open-cart bitnami/opencart --set opencartPassword=$APP_PASSWORD,opencartHost=$APP_HOST,service.type=LoadBalancer,mariadb.enabled="false",externalDatabase.host="10.176.193.6",externalDatabase.user="ocuser",externalDatabase.password="VMware1!",externalDatabase.database="opencart"
```
Note: Will need to do a few updates before you execute the helm upgrade command. you need to  update your repo to bitnami/opencart instead of my-repo/opencart and add double quoats to all the values except the variables. 


Once Excuted you will have the generated OpenCart URL

```
helm upgrade --namespace default my-open-cart bitnami/opencart --set opencartPassword=$APP_PASSWORD,opencartHost=$APP_HOST,service.type=LoadBalancer,mariadb.enabled=false,externalDatabase.host="10.176.193.6",externalDatabase.user="ocuser",externalDatabase.password="VMware1!",externalDatabase.database="opencart"
Release "my-open-cart" has been upgraded. Happy Helming!
NAME: my-open-cart
LAST DEPLOYED: Wed Apr 19 08:27:34 2023
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
CHART NAME: opencart
CHART VERSION: 13.0.12
APP VERSION: 4.0.1-1

** Please be patient while the chart is being deployed **1. Get the OpenCart URL by running:

  echo "Store URL: http://10.176.193.17/"
  echo "Admin URL: http://10.176.193.17/admin"

2. Get your OpenCart login credentials by running:

  echo Admin Username: user
  echo Admin Password: $(kubectl get secret --namespace default my-open-cart-opencart -o jsonpath="{.data.opencart-password}" | base64 -d)
```

# E. Query your Opencart Obejcts 

```
# kubectl get all

NAME                                         READY   STATUS    RESTARTS   AGE
pod/my-open-cart-opencart-7cd46d854c-rlkjp   1/1     Running   0          81s

NAME                            TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
service/kubernetes              ClusterIP      10.96.0.1      <none>          443/TCP                      123m
service/my-open-cart-opencart   LoadBalancer   10.96.75.187   10.176.193.18   80:32532/TCP,443:31356/TCP   2m7s
service/supervisor              ClusterIP      None           <none>          6443/TCP                     123m

NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/my-open-cart-opencart   1/1     1            1           81s

NAME                                               DESIRED   CURRENT   READY   AGE
replicaset.apps/my-open-cart-opencart-7cd46d854c   1         1         1       81s

```
```
# kubectl get pvc
NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS                    AGE
my-open-cart-opencart-opencart   Bound    pvc-5eedeed0-db29-40e6-b05a-4d32d4e1ddbd   8Gi        RWO            tmm-kubernetes-storage-policy   3m32s
```
```
# k get secrets
NAME                                 TYPE                                  DATA   AGE
default-token-j8r9z                  kubernetes.io/service-account-token   3      126m
my-open-cart-opencart                Opaque                                1      5m4s
my-open-cart-opencart-externaldb     Opaque                                1      5m4s
sh.helm.release.v1.my-open-cart.v1   helm.sh/release.v1                    1      5m4s
sh.helm.release.v1.my-open-cart.v2   helm.sh/release.v1                    1      4m18s

```

# F. Hit the new Store URL: http://10.176.193.17/

