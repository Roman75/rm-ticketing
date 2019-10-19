#!/bin/bash

source ./.env

for repo in "${REPOSITORIES[@]}"
do
    :
    sh release.sh $repo
done

