#!/bin/bash

if [ -z "$1" ]
then
    echo "";
    echo "USAGE:";
    echo "sh repo.sh REPOSITORY [patch|minor|major]";
    echo "";
    echo "EXAMPLES:";
    echo "sh repo.sh rm-ticketing-node-server patch";
    echo "sh repo.sh rm-ticketing-mysql-server patch";
    echo "sh repo.sh rm-ticketing-admin patch";
    echo "sh repo.sh rm-ticketing-promoter patch";
    echo "sh repo.sh rm-ticketing-scanner patch";
    echo "sh repo.sh rm-ticketing-page patch";
    echo "sh repo.sh rm-ticketing-tests patch";
    echo "";
    exit 1
fi

if [ -z "$2" ]
then
    TYPE="patch"
else
    TYPE=$2
fi

cd ..
source ./.env

DIR=$PROJECT_PATH/$1
README=$PROJECT_PATH/$1/README.md

echo "============================================"
echo "repo: $1"
echo $TYPE
echo "============================================"

cd $DIR
git pull

docker run --rm -v $DIR:/app treeder/bump $TYPE
version=`cat $DIR/VERSION`

sh build.sh
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
echo "release type: $TYPE"
echo "version: $version"
echo "finished"
echo "============================================"
