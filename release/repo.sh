#!/bin/bash

if [ -z "$1" ]
then
    echo "";
    echo "usage for this file:";
    echo "sh release.sh REPOSITORY";
    echo "";
    echo "examples:";
    echo "sh release.sh rm-ticketing-node-server";
    echo "sh release.sh rm-ticketing-mysql-server";
    echo "sh release.sh rm-ticketing-admin";
    echo "sh release.sh rm-ticketing-promoter";
    echo "sh release.sh rm-ticketing-scanner";
    echo "sh release.sh rm-ticketing-page";
    echo "sh release.sh rm-ticketing-tests";
    echo "";
    exit 1
fi

cd ..
source ./.env

DIR=$PROJECT_PATH/$1
README=$PROJECT_PATH/$1/README.md

echo "============================================"
echo "repo: $1"
echo "============================================"

cd $DIR
git pull

docker run --rm -v $DIR:/app treeder/bump patch
version=`cat VERSION`

echo "update version number: $version"

sh jsdoc.sh

git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker build --force-rm --no-cache -t $USERNAME/$1:latest .
docker push $USERNAME/$1:latest

echo "============================================"
echo "repo: $1"
echo "version: $version"
echo "finished release"
echo "============================================"

cd release
