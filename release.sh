#!/bin/bash

source ./access.txt

repositories=(rm-ticketing-admin rm-ticketing-mysql-server rm-ticketing-node-server rm-ticketing-page rm-ticketing-promoter rm-ticketing-scanner)

for repo in "${repositories[@]}"
do
    :

    DIR=$PROJECT_PATH/$repo
    README=$PROJECT_PATH/$repo/README.md

    cd $DIR
    git pull

    sh jsdoc.sh

    docker run --rm -v $DIR:/app treeder/bump patch
    version=`cat VERSION`
    echo "======================="
    echo "repo: $repo"
    echo "version: $version"
    echo "======================="

    git add -A
    git commit -m "version $version"
    git tag -a "$version" -m "version $version"
    git push
    git push --tags

    docker build --force-rm --no-cache -t $USERNAME/$repo:latest .
    #docker tag $USERNAME/$repo:latest $USERNAME/$repo:$version
    docker push $USERNAME/$repo:latest

done

