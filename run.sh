#!/bin/bash

#### Functions ###
display_usage() {
  echo "\nUsage: $0 [OPTIONS]"
  echo "\nThis script must be run with Docker capable privileges!"
  echo "\nOptions:"
  echo "  -n <name>  Set the project name (required)"
  echo "  -v <version>  PHP version (Default: 7.4)"
  echo "  -p <port>  Set the project PORT (Default: 80)"
}

# Check params
if [ $# -le 0 ]; then
  display_usage
  exit 1
fi

version=7.4
port=80

while getopts "hls:n:v:p:" opt; do
  case $opt in
    h) display_usage && exit 0 ;;
    v) version=$OPTARG ;;
    n) name=$OPTARG ;;
    p) port=$OPTARG ;;
  esac
done

if [ -z "$name" ]; then
  echo 'Parameter -p missing'
  exit
fi

export PHP_VERSION=$version
export PROJECT_NAME=$name
export PROJECT_PORT=$port

echo Deleting containers
docker rm -f php nginx

echo Uploading Application container 
docker-compose up --build -d

echo Install dependencies
docker exec -it php composer --version
docker exec -it php composer install

echo Copying env variables
docker exec -it php cp /var/www/app/.env.example /var/www/app/.env

echo Laravel Key Generating
docker exec -it php php /var/www/app/artisan key:generate

echo Changing storage permissions
docker exec -it php chmod 777 -R /var/www/app/storage/

echo Information of new containers
docker ps