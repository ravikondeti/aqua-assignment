# aqua-assignment
aqua-assignment

STEP 1: Create prerequisites for terraform backend state files
a. navigate to aqua-assignment/prerequisites folder
b. if required modify "region" and "s3 bucket"  variables in pre.auto.tfvars
c. then run terrform init, terraform validate
d. after successful validation, run terraform plan && terraform apply --auto-approve
f. After successful execution, S3 bucket and dynamo db tables get created.
note: pre.auto.tfvars file is used as variable file