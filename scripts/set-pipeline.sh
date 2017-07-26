#!/bin/bash -e


syntax() {
  echo "Usage: set-pipeline.sh concourse-target pipelineName"
}

PIPELINE_DIR=$(dirname "$0")/..

if [ "$#" -ne 2 ]; then
  syntax
  exit 1
fi

FLY_TARGET=$1
PIPELINE=$2
CREDENTIALS=credentials.yml
SECRETS=secrets.yml

echo "Setting $PIPELINE pipeline in Concourse ..."
fly -t "$FLY_TARGET" set-pipeline -p "$PIPELINE" \
  -c "$PIPELINE_DIR"/ci/application/pipeline.yml -l "$PIPELINE_DIR"/credentials.yml -l "$PIPELINE_DIR"/secrets.yml \
