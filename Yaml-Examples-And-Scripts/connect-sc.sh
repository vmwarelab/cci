export SC_IP=Your_Supervisor_IP
export KUBECTL_VSPHERE_PASSWORD=Your_vSphere_Password
kubectl vsphere login --server=https://$SC_IP --vsphere-username Your_vSphere_Username --insecure-skip-tls-verify


