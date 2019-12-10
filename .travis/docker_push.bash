#! /bin/bash

set -e

if [ -z "${DOCKER_USERNAME}" ]
then
  echo "Empty DOCKER_USERNAME!";
  exit 1;
fi

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
docker push "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}";
