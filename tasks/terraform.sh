#!/bin/sh

env | grep TF_VAR 

cd artifact
ARTIFACT=`ls *`

function tar {
    tar -xvf $ARTIFACT    
}

case ${ARTIFACT_TYPE} in 
tar) 
    tar
    ;;
*)
    echo $"Expected artifact type : tar"      
    exit 1
 
esac

cd terraform 
terraform plan
