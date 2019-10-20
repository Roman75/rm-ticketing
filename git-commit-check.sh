#!/bin/bash

source ./.env

git commit

for repo in "${REPOSITORIES[@]}"
do
    :
    cd $repo
    git commit
    cd ..
done
