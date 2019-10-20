#!/bin/bash
docker-compose down
docker image prune -f
docker container prune -f
docker-compose pull
docker-compose --file docker-compose.yaml up -d
docker-compose logs -f
