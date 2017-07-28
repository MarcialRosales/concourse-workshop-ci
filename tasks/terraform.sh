#!/bin/sh

env | grep TF_VAR 

cd source-code/deployments

terraform plan
