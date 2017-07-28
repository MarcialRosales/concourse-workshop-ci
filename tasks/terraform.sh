#!/bin/bash

env | grep TF_VAR 

cd artifact
ARTIFACT=`ls *`

unzip $ARTIFACT $TERRAFORM_PATH/*

cd $TERRAFORM_PATH 
terraform plan
