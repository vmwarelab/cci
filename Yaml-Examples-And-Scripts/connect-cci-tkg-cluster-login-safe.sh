export NAMESPACE=Your_Namespace
export TKG_CLUSTER=Your_TKG_Cluster_Name
export PROJECT=Your_Project
export CCI_USER_NAME=Your_User_Name
export KUBECTL_VSPHERE_PASSWORD=Your_Password
export KUBECTL_CCI_PASSWORD=Your_Password

kubectl cci login --server vcf-auto.corp.vmbeans.com --username $CCI_USER_NAME --project $PROJECT --tanzu-kubernetes-cluster-namespace $NAMESPACE --tanzu-kubernetes-cluster-name $TKG_CLUSTER --insecure-skip-tls-verify
