#!/bin/bash
# mantainer: @chaconmelgarejo
# gcp study notes - appengine

# download the app using git
# python, java, go, nodejs
# create one per project and region file with the specification
gcloud app create

#deploy the fisrt version and read spec from app.yaml
gcloud app deploy

#if you need to deploy a version 2 and no split all trafic
gcloud app deploy --no-promote

# you can mapping your domain and certificates with cert manager
gcloud app domain-mappings create $mydomain

#you could split the traffic between versions
# can split by ip, random and cookie
gcloud app services set-traffic --splits v2=.5,v1=.5

# access ssh into the instance in flexible env
gcloud app instances ssh --service s1 --version v1 i1
# manage instances: https://cloud.google.com/sdk/gcloud/reference/app/instances
