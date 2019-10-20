# local developement setup

## fetch all dependent repositories

setup a local developement environment

```bash
cd PATH_TO_YOUR_LOCAL_GIT_REPOSITORIES # (any path  you store your projects)
git clone git@github.com:Roman75/rm-ticketing.git
cd rm-ticketing
git clone git@github.com:Roman75/rm-ticketing-admin.git
git clone git@github.com:Roman75/rm-ticketing-mysql-server.git
git clone git@github.com:Roman75/rm-ticketing-node-server.git
git clone git@github.com:Roman75/rm-ticketing-page.git
git clone git@github.com:Roman75/rm-ticketing-promoter.git
git clone git@github.com:Roman75/rm-ticketing-scanner.git
git clone git@github.com:Roman75/rm-ticketing-tests.git
```

## create .env file with project information with following content

```bash
REPOSITORIES=(rm-ticketing-admin rm-ticketing-mysql-server rm-ticketing-node-server rm-ticketing-page rm-ticketing-promoter rm-ticketing-scanner rm-ticketing-tests)
PROJECT_PATH="PATH_TO_DIRECTORY/rm-ticketing"
USERNAME="user1"
PASSWORD="Passw0Rd!"
```

## copy node server config-default.yaml to config.yaml and adjust settings

```bash
cd rm-ticketing-node-server
cp config-default.yaml config.yaml
edit config.yaml # adjust your settings (eg mailserver connection)
```
 

## create docker-compose.yaml file for local developement

this file should already exist

```yaml
version: "3.7"

services:

  rm_ticketing_mysql_server:
    image: romarius75/rm-ticketing-mysql-server:latest
    ports:
    - 3306:3306
    volumes:
    - rm_ticketing_mysql_volume:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${PASSWORD}

  rm_ticketing_node_server:
    image: romarius75/rm-ticketing-node-server:latest
    ports:
    - 80:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-node-server\config.yaml:/app/config.yaml
    depends_on:
    - rm_ticketing_mysql_server

  rm_ticketing_admin:
    image: romarius75/rm-ticketing-admin:latest
    ports:
    - 8081:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-admin\config.yaml:/app/config.yaml

  rm_ticketing_promoter:
    image: romarius75/rm-ticketing-promoter:latest
    ports:
    - 8082:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-promoter\config.yaml:/app/config.yaml

  rm_ticketing_page:
    image: romarius75/rm-ticketing-page:latest
    ports:
    - 8083:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-page\config.yaml:/app/config.yaml

  rm_ticketing_scanner:
    image: romarius75/rm-ticketing-scanner:latest
    ports:
    - 8084:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-scanner\config.yaml:/app/config.yaml

  rm_ticketing_tests:
    image: romarius75/rm-ticketing-tests:latest
    ports:
    - 8085:8080
    volumes:
    - ${PROJECT_PATH}\rm-ticketing-tests\config.yaml:/app/config.yaml

volumes:
  rm_ticketing_mysql_volume:

```

```yaml
docker-compose up -d
```
