# aqua-assignment
aqua-assignment

STEP 1: Create prerequisites for terraform backend state files
a. navigate to aqua-assignment/prerequisites folder
b. if required modify "region" and "s3 bucket"  variables in pre.auto.tfvars
c. then run terrform init, terraform validate
d. after successful validation, run terraform plan && terraform apply --auto-approve
f. After successful execution, S3 bucket and dynamo db tables get created.
note: pre.auto.tfvars file is used as variable file

STEP 2: Build Lambda GO function 
a. write go function using go kubernetes client and build function for linux environemnt
   command: GOOS=linux GOARCH=amd64 go build handler.go
b. build aws-iam-authenticator binary
c. prepare kubeconfig file with all cluster information(can copy cube config file from ~/.kube/config) and append with aws-iam-authenticator section as stated in kubeconfig file.
d. keep all these three files in "deploymentmodule/handler" folder (terraform will zip and deploy to lambda)

