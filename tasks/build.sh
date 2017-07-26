#!/bin/sh

set -eu

VERSION=`cat version/number`-SNAPSHOT

cd source-code

echo "Setting maven with version ${VERSION}"
mvn versions:set -DnewVersion=${VERSION}

mvn package
#mkdir target
#touch target/demo-0.0.1-SNAPSHOT.jar


echo "Copying artifacts ..."
cp -r target/*.jar ../build-artifact
