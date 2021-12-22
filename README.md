# aqua-assignment
aqua-assignment
Pre requisites:
    Aws cli, kubectl must be installed

Folder structure:

- Assignment
  - deploymentmodule
      - handler(keeps lambda function files)
      - terraform files
  - inframodule
       - terraform files
  - prerequisites
        - terraform files
  - role.yaml
  - rolebinding.yml

STEP 1: Create prerequisites for terraform backend state files
- navigate to aqua-assignment/prerequisites folder
- if required modify "region" and "s3 bucket"  variables in pre.auto.tfvars
- then run terrform init, terraform validate
- after successful validation, run terraform plan && terraform apply --auto-approve
- After successful execution, S3 bucket and dynamo db tables get created.
 - note: pre.auto.tfvars file is used as variable file

STEP 2: Build infra module
a. navigate to inframodule folder
b. if required, modify cluster_name, poolsize or region in "eks.auto.tfvars" file.
c. if required, modify vpc related information in "vpc.auto.tfvars" file.
d. then run below commands
   1. terraform init
   2. terraform validate
   3. terraform plan
   4. if no errors encountered during above steps execute terraform apply --auto-approve
note : after successful completion of creating EKS cluster, terraform create "kuebeconfig" inside its directory.


STEP 3: Build Lambda GO function 
a. write go function using go kubernetes client and build function for linux environemnt
   command: GOOS=linux GOARCH=amd64 go build handler.go
b. build aws-iam-authenticator binary
c. prepare kubeconfig file with all cluster information(can copy cube config file from ~/.kube/config or can copy from inframodule/kubeconfig_aqua_assignment_eks_cluster to kubeconfig file).
d. file name must be kubeconfig and present in "deploymentmodule/handler" folder
e. copy above three files to "deploymentmodule/handler" folder (terraform will zip and deploy to lambda)


STEP4: navigate to deployment folder
a. navigate to deploymentmodule folder
b. run below commands
   1. terraform init
   2. terraform validate
   3. terraform plan
   4. if no errors encountered during above steps execute terraform apply --auto-approve


step 5: create RBAC role & rolebinding to grant access to lambda role 
a. to update RBAC role configuration, kubectl must be installed.
b. then run below command to update kube config.
    aws eks --region $(terraform output -raw aws_region) update-kubeconfig --name $(terraform output -raw cluster_name)
c. navigate to "assignment" folder and locate role.yml & rolebinding.yml
d. run below commands to apply RBAC config.
    kubectl apply -f role.yaml
    kubectl apply -f rolebinding.yaml

STEP 6: 
a. Find API end point from terraform output or from AWS API Gateway service.
b. run api endpoint by apending "/getpodslist"
 ex: https://l3n6x6okv3.execute-api.ap-south-1.amazonaws.com/aqua_assignment_api_gw_stage/getpodslist

Additional  Requirements:
-------------------------
a. The output of Terraform should print the AWS CLI command required to connect the cluster
--> this output is printed under "inframodule".

b. Users should be able to control the following via variables:
    sre-pool-main and sre-pool-sec node pool size
    Deployment VPC region
    Name of cluster
--> input these variables in "eks.auto.tfvars" file under "inframodule" folder