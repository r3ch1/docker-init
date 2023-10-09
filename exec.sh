#!/bin/bash
PHP_VERSION='7.4'
PROJECT_NAME=$(basename "`pwd`")
PROJECT_FOLDER=''
XDEBUG_VERSION='-3.1.0'

read -p "Enter project name [$PROJECT_NAME]: " sRead
sRead=${sRead:-$PROJECT_NAME}
PROJECT_NAME=$sRead

read -p "Enter PHP version required [$PHP_VERSION]: " sRead
sRead=${sRead:-$PHP_VERSION}
PHP_VERSION=$sRead

read -p "Enter project code [.]: " sRead
sRead=${sRead:-$PROJECT_FOLDER}
PROJECT_FOLDER=$sRead
if [ $PROJECT_FOLDER != '' ] 
then
    PROJECT_FOLDER=/$PROJECT_FOLDER;
fi

if [ $PHP_VERSION != '7.4' ]
then
    XDEBUG_VERSION=''
fi


echo $PROJECT_NAME
echo $PROJECT_FOLDER
echo $PHP_VERSION

cp -R /home/rechi/projetos/personal/docker-init/base /home/rechi/projetos/personal/docker-init/to-export

sed "s!{{project-name}}!${PROJECT_NAME}!ig" /home/rechi/projetos/personal/docker-init/to-export/docker-compose.yml > /home/rechi/projetos/personal/docker-init/to-export/docker-compose-base.yml
sed "s!{{project-folder}}!${PROJECT_FOLDER}!ig" /home/rechi/projetos/personal/docker-init/to-export/docker-compose-base.yml > /home/rechi/projetos/personal/docker-init/to-export/docker-compose.yml
rm -rf /home/rechi/projetos/personal/docker-init/to-export/docker-compose-base.yml

sed "s!{{php-version}}!${PHP_VERSION}!ig" /home/rechi/projetos/personal/docker-init/to-export/docker/Dockerfile > /home/rechi/projetos/personal/docker-init/to-export/docker/Dockerfile-base
sed "s!{{xdebug-version}}!${XDEBUG_VERSION}!ig" /home/rechi/projetos/personal/docker-init/to-export/docker/Dockerfile-base > /home/rechi/projetos/personal/docker-init/to-export/docker/Dockerfile
rm -rf /home/rechi/projetos/personal/docker-init/to-export/docker/Dockerfile-base

sed "s!{{project-name}}!${PROJECT_NAME}!ig" /home/rechi/projetos/personal/docker-init/to-export/docker/nginx/nginx.conf > /home/rechi/projetos/personal/docker-init/to-export/docker/nginx/nginx-base.conf
mv /home/rechi/projetos/personal/docker-init/to-export/docker/nginx/nginx-base.conf /home/rechi/projetos/personal/docker-init/to-export/docker/nginx/nginx.conf

cp -R /home/rechi/projetos/personal/docker-init/to-export/* .
rm -rf /home/rechi/projetos/personal/docker-init/to-export