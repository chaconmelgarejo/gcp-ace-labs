#!/bin/bash
# mantainer: @chaconmelgarejo
# gcp study notes - projects and initial conf

#initial configure easy auth for personals accounts
gcloud init

# list active configurations named - manage many confs diff projects : create, activate, delete, list and describe
gcloud config configurations list

#get specific value from SDK properties
gcloud config get-value project
# output project activated
gcloud config get-value core/account
#output mail account activated
# more info: gcloud config get-value --help 

#set account - also we could unset properties
mail_account="my-user@gmail.com"
gcloud config set account $mail_account

#set project
project_id="my-crazy-gcp-project"
gcloud config set project $project_id

#activate a Service Account - App purpose
# we need to generate a SA and the key first
sa_name= "my-service-account"
gcloud iam service-accounts create $sa_name --display-name $sa_name

#create key for associate to the SA
gcloud iam service-accounts keys create ${sa_name}.json \
      --iam-account ${sa_name}@${project_id}.iam.gserviceaccount.com


path_key="/home/my-service-account.json"
gcloud config set project $project_id
gcloud config set account $mail_service_account
gcloud auth activate-service-account $mail_account --key-file=$path_key

#manage projects
gcloud projects list

project_id="my-new-project-1234"
# create projects with project-id=project-name if we do not specified
gcloud projects create $project_id
# more info: gcloud projects create --help  || add labels, activate apis, specified name and set as default

#set policy  and binding for a project (update && delete) interesting: undelete lol
path_policy="my-policies.yaml"
# https://cloud.google.com/iam/reference/rest/v1/Policy
# ex: gcloud projects set-iam-policy example-project-id-1 policy.json
gcloud projects set-iam-policy $project_id $path_policy
# create a $new-role then:
gcloud projects add-iam-policy-binding $project_id \
    --member user:$mail_account --role $new-role
# if we will user a service account : serviceAccount:$mail_service_account
#more info: gcloud projects add-iam-policy-binding --help

new_role="roles/viewer"
mail_account="my-user@dominio.com"
# ex: grant viewer role - primitive role
gcloud projects add-iam-policy-binding $project_id \
    --member=user:$mail_account --role $new_role
# revoke viewer role
gcloud projects remove-iam-policy-binding $project_id \
    --member=user:$mail_account --role $new_role

#manage roles
gcloud iam roles list

# create role from yaml file
rolefile="roles.yaml"
gcloud iam roles create $roleid --project=$project \
   --file=$rolefile
#ex describe role
gcloud iam roles describe roles/iam.roleViewer
