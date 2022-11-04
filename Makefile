region ?= europe-north1
projectid = $(shell gcloud config get project)

tfstate_gcs_bucket = terraform-sandbox-0-state-files

ifndef env 
$(error Environment variable 'env' not set)
endif

ifndef layer 
$(error Environment variable 'layer' not set)
endif

ifdef OS
	#Windows stuff
	RM = if exist .terraform\ (rd /S /Q .terraform\) 
	DEF = set
else
	#Linux stuff
	ifeq ($(shell uname), Linux)
		RM = rm -rf .terraform/
		DEF = export
	else
		DEF = export
	endif
endif

fmt:
	cd environments && terraform fmt -recursive
	cd layers && terraform fmt -recursive

init:
	cd environments/$(env) && $(RM) 
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	terraform -chdir=../../layers/$(layer)/ init -upgrade -backend=true \
		-backend-config="bucket=$(tfstate_gcs_bucket)" \
		-backend-config="prefix=$(projectid)/$(layer)/terraform.tfstate" 

validate:
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	terraform -chdir=../../layers/$(layer)/ validate ../../layers/$(layer)/

plan: validate
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	$(DEF) TF_VAR_env=$(env) && \
	terraform -chdir=../../layers/$(layer)/ plan -var-file=../../environments/$(env)/terraform.tfvars -out ../../plan_files/tf_plan_$(layer).plan

apply:
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	$(DEF) TF_VAR_env=$(env) && \
	terraform -chdir=../../layers/$(layer)/ apply ../../plan_files/tf_plan_$(layer).plan

plan-destroy:
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	$(DEF) TF_VAR_env=$(env) && \
	terraform -chdir=../../layers/$(layer)/ plan -destroy -out ../../plan_files/tf_plan_destroy_$(layer).plan  

destroy:
	cd environments/$(env) && \
	$(DEF) TF_DATA_DIR=../../environments/$(env)/.terraform&& \
	$(DEF) TF_VAR_env=$(env) && \
	terraform destroy -chdir=../../layers/$(layer)/
