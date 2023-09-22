export CCI_API_TOKEN=Your_Admin_Token
export SERVER=Your_API_Server
kubectl cci login -t $CCI_API_TOKEN --server $SERVER --skip-set-context --insecure-skip-tls-verify
