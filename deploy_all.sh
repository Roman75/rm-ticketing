#!/bin/bash

echo "";
echo "USAGE:";
echo "sh all.sh [patch (DEFAULT)|minor|major]";
echo "";
echo "EXAMPLES:";
echo "sh all.sh (bump 0.0.1)";
echo "sh all.sh patch (bump 0.0.1)";
echo "sh all.sh minor (bump 0.1.0)";
echo "sh all.sh major (bump 1.0.0)";
echo "";

if [ -z "$1" ]
then
    TYPE="patch"
else
    TYPE=$2
fi

source .env

for repo in "${REPOSITORIES[@]}"
do
    :
    sh deploy.sh $repo $TYPE
done

