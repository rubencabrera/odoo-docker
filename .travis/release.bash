#!/bin/bash

set -e

if [ -z "${GH_TOKEN}"]
then
  echo "No GH_TOKEN defined!";
  exit 1;
fi

pwd
docker build -t "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}" .
nvm install lts/*
npx semantic-release
