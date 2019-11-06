#! /bin/bash

set -e

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
docker push "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}";
