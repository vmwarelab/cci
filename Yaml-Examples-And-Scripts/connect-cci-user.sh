export CCI_API_TOKEN=Your_User_Token
export SERVER=Your_API_Server
kubectl cci login -t $CCI_API_TOKEN --server $SERVER --insecure-skip-tls-verify
