#!/bin/bash
PHP_VERSION='7.4'
PROJECT_NAME=$(basename "`pwd`")
PROJECT_FOLDER=''
XDEBUG_VERSION='-3.1.0'
BASEDIR=$(dirname "$0")

echo "$BASEDIR"

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

cp -R ${BASEDIR}/base ${BASEDIR}/to-export

sed "s!{{project-name}}!${PROJECT_NAME}!ig" ${BASEDIR}/to-export/docker-compose.yml > ${BASEDIR}/to-export/docker-compose-base.yml
sed "s!{{project-folder}}!${PROJECT_FOLDER}!ig" ${BASEDIR}/to-export/docker-compose-base.yml > ${BASEDIR}/to-export/docker-compose.yml
rm -rf ${BASEDIR}/to-export/docker-compose-base.yml

sed "s!{{php-version}}!${PHP_VERSION}!ig" ${BASEDIR}/to-export/docker/Dockerfile > ${BASEDIR}/to-export/docker/Dockerfile-base
sed "s!{{xdebug-version}}!${XDEBUG_VERSION}!ig" ${BASEDIR}/to-export/docker/Dockerfile-base > ${BASEDIR}/to-export/docker/Dockerfile
rm -rf ${BASEDIR}/to-export/docker/Dockerfile-base

sed "s!{{project-name}}!${PROJECT_NAME}!ig" ${BASEDIR}/to-export/docker/nginx/nginx.conf > ${BASEDIR}/to-export/docker/nginx/nginx-base.conf
mv ${BASEDIR}/to-export/docker/nginx/nginx-base.conf ${BASEDIR}/to-export/docker/nginx/nginx.conf

cp -R ${BASEDIR}/to-export/* .
rm -rf ${BASEDIR}/to-export