export CCI_USER_NAME=Your_User_Name@Your_Domain
export KUBECTL_CCI_PASSWORD=Your_User_Password
kubectl cci login -u $CCI_USER_NAME --server vsfa_fqdn_ip --insecure-skip-tls-verify
