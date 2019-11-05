#!/bin/bash
docker-compose pull
docker-compose --force-recreate --build up -d
docker-compose logs -f
