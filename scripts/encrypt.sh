#!/bin/bash -e

which lpass || echo "install lpass cli"; exit 1;
file secrets.yml  || echo "secrets.yml not found"; exit 1;

syntax() {
  echo "Usage: encrypt.sh pipelineName"
}

if [ "$#" -ne 1 ]; then
  syntax
  exit 1
fi

PIPELINE=$1

p=`lpass show --password localhost/$PIPELINE`; gpg --batch --passphrase="$p" --cipher-algo AES256 --symmetric secrets.yml ;  unset p
git add `secrets.yml.gpg`
git commit -m "modified secrets"
