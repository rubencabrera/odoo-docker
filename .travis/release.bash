#!/bin/bash

set -e

if [ -z "${GH_TOKEN}"]
then
  echo "GH_TOKEN not defined";
  exit 1;
else
  echo "GH_TOKEN token defined"
fi

echo "Building image again"
docker build -t "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}" .
