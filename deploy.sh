#!/bin/bash

if [ -z "$1" ]
then
    echo "";
    echo "USAGE:";
    echo "sh deploy.sh REPOSITORY [patch (DEFAULT)|minor|major]";
    echo "";
    echo "sh deploy.sh (bump 0.0.1)";
    echo "sh deploy.sh patch (bump 0.0.1)";
    echo "sh deploy.sh minor (bump 0.1.0)";
    echo "sh deploy.sh major (bump 1.0.0)";
    echo "";
    echo "EXAMPLES:";
    echo "sh deploy.sh rm-ticketing-node-server patch";
    echo "sh deploy.sh rm-ticketing-mysql-server patch";
    echo "sh deploy.sh rm-ticketing-admin patch";
    echo "sh deploy.sh rm-ticketing-promoter patch";
    echo "sh deploy.sh rm-ticketing-scanner patch";
    echo "sh deploy.sh rm-ticketing-page patch";
    echo "sh deploy.sh rm-ticketing-tests patch";
    echo "";
    exit 1
fi

if [ -z "$2" ]
then
    TYPE="patch"
else
    TYPE=$2
fi

source ./.env

DIR=$PROJECT_PATH/$1

echo "============================================"
echo "repo: $1"
echo $TYPE
echo "============================================"

cd $DIR
git pull

docker run --rm -v $DIR:/app treeder/bump $TYPE
version=`cat $DIR/VERSION`

sh deploy.sh

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
