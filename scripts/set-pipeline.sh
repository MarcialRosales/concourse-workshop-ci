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


tmp=$(mktemp $TMPDIR/pipeline.XXXXXX.yml)
trap 'rm $tmp' EXIT

PIPELINE_FILES="$PIPELINE_DIR/ci/application/pipeline.yml"

echo "Generating $PIPELINE pipeline ..."
spruce merge --prune meta --prune pipeline --prune app --prune deployment $PIPELINE_FILES $CREDENTIALS $SECRETS > $tmp

echo "Setting $PIPELINE pipeline in Concourse ..."
fly -t "$FLY_TARGET" set-pipeline -p "$PIPELINE" -c $tmp
