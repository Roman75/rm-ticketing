#!/bin/bash

cd ..
source ./.env

for repo in "${REPOSITORIES[@]}"
do
    :
    cd $repo
    echo "==========================="
    echo $repo
    echo "==========================="
    git status
    cd ..
done
cd git
