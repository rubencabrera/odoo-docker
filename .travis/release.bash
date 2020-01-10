#!/bin/bash

set -e

if [ -z "${GH_TOKEN}" && -z "${GITHUB_TOKEN}"]
then
  echo "Neither GH_TOKEN nor GITHUB_TOKEN defined!";
  exit 1;
fi

pwd
docker build -t "${TRAVIS_REPO_SLUG}:${TRAVIS_BRANCH}" .
nvm install lts/*
npx semantic-release
