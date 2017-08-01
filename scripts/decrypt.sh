#!/bin/bash -e

which lpass || echo "install lpass cli"; exit 1;
file secrets.yml.gpg  || echo "secrets.yml.gpg not found"; exit 1;

syntax() {
  echo "Usage: decrypt.sh pipelineName"
}

if [ "$#" -ne 1 ]; then
  syntax
  exit 1
fi

PIPELINE=$1

p=`lpass show --password localhost/$PIPELINE`; gpg  --batch --passphrase="$p" -d $SECRETS.gpg > $SECRETS; unset p