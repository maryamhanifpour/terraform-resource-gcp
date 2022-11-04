
Assumption: SERVICE ACCOUNT USED BY TERRAFORM is clready created and has sufficient policies to create resources.


gcloud iam service-accounts get-iam-policy [SERVICE ACCOUNT USED BY TERRAFORM] > tf_policy.yaml

Extend tf_policy.yaml to look like policy.yaml

gcloud iam service-accounts set-iam-policy [SERVICE ACCOUNT USED BY TERRAFORM] tf_policy.yaml

tfstate_gcs_bucket is created.

## creating resources
export env=dev

export layer=compute

make fmt

make init

make plan

make apply

