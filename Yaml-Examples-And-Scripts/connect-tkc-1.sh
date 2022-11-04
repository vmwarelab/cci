export SC_IP=Your_Supervisor_IP
export NAMESPACE=Your_Namespace
export KUBECTL_VSPHERE_PASSWORD=Your_vSphere_Password
kubectl vsphere login --server=https://$SC_IP --tanzu-kubernetes-cluster-name tkc-1 --tanzu-kubernetes-cluster-namespace $NAMESPACE --vsphere-username administrator@vsphere.local --insecure-skip-tls-verify
