#!/bin/bash
docker-compose down
docker image prune -f
docker container prune -f
docker-compose pull
docker-compose up rm_ticketing_mysql_server -d
