#!/bin/bash
docker-compose --file docker-compose-dev.yaml up -d
docker-compose logs -f
