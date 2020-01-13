#! /bin/bash

set -e

if [ -z "${DOCKER_USERNAME}" ];
then
  echo "Empty DOCKER_USERNAME variable!";
  exit 1;
fi

echo "Building image again"
docker build -t "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}" .
echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
docker push "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}";
