#!/bin/bash

if [ -z "$3" ]
then
    echo "";
    echo "usage for this file:";
    echo "sh release.sh IMAGE USERNAME PASSWORD";
    echo "";
    echo "examples:";
    echo "sh release.sh rm-ticketing-node-server user1 passw0rd1";
    echo "sh release.sh rm-ticketing-mysql-server user1 passw0rd1";
    echo "sh release.sh rm-ticketing-admin user1 passw0rd1";
    echo "sh release.sh rm-ticketing-page user1 passw0rd1";
    echo "sh release.sh rm-ticketing-promoter user1 passw0rd1";
    echo "sh release.sh rm-ticketing-scanner user1 passw0rd1";
    echo "";
    exit 1
fi

IMAGE=$1
USERNAME=$2
PASSWORD=$3

DIR=e:/git/rm-ticketing/$IMAGE
README=e:/git/rm-ticketing/$IMAGE/README.md

cd $DIR
# ensure we're up to date
git pull

# bump version
docker run --rm -v $DIR:/app treeder/bump patch
version=`cat VERSION`
echo "version: $version"

# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags

docker build --force-rm --no-cache -t $USERNAME/$IMAGE:latest .
docker push $USERNAME/$IMAGE:latest

#docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version

# push it
#docker push $USERNAME/$IMAGE:latest
#docker push $USERNAME/$IMAGE:$version

#docker image rm --force $USERNAME/$IMAGE:latest
#docker image rm --force $USERNAME/$IMAGE:$version

#echo "GET TOKEN"
#TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${USERNAME}'", "password": "'${PASSWORD}'"}' ${API_URL}/users/login/ | sed -e 's/.*"token": "\(.*\)".*/\1/')
#echo $TOKEN

#echo "UPDATE DOCKERHUB"
#RESPONSE=$(curl -s --write-out %{response_code} --output /dev/null -H "Authorization: JWT ${TOKEN}" -X PATCH --data-urlencode full_description@${README} ${API_URL}/repositories/${REPO}/)
