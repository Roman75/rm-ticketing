#!/bin/bash

repositories=(rm-ticketing-admin rm-ticketing-mysql-server rm-ticketing-node-server rm-ticketing-page rm-ticketing-promoter rm-ticketing-scanner rm-ticketing-tests)

for repo in "${repositories[@]}"
do
    :
    sh release.sh $repo
done

