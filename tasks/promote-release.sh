#!/bin/sh

set -eu

cp -R deployment-manifest/. deployment-manifest-updated  # duplicate git repo files for update

VERSION=`cat version/number`

cd deployment-manifest-updated

git checkout promote-deployments    # make changes to a branch other than master

set +x
cat > manifest.yml <<EOF
version: ${VERSION}
EOF

cat $MANIFEST_FILE

git add . && git commit -m "Promote version $VERSION"  # stage changes and prep for following PUT action against git repo
