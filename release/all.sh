#!/bin/bash

source ../.env

for repo in "${REPOSITORIES[@]}"
do
    :
    sh repo.sh $repo
done

