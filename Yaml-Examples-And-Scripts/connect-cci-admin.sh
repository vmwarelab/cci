export CCI_API_TOKEN=Your_Admin_Token
export SERVER=Your_API_Server
kubectl cci login -t $CCI_API_TOKEN --server $SERVER --skip-set-context --insecure-skip-tls-verify

# Create contexts for specific supervisor namespace from a specific project, since no contexts will be automatically created due to use "--skip-set-context" parameter
# kubectl cci set-context --project Your_Project_Name --supervisor-namespace Your_Supervisor_Namespace
# This will create a context in the format cci:projectname:supervisornamespace
