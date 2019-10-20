#!/bin/bash

source ./.env

for repo in "${REPOSITORIES[@]}"
do
    :
    cd $repo
    echo "==========================="
    echo $repo
    echo "==========================="
    git commit
    cd ..
done
