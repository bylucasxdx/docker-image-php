#!/bin/bash

#### Functions ###
display_usage() {
  echo "\nUsage: $0 [OPTIONS]"
  echo "\nThis script must be run with Docker capable privileges!"
  echo "\nOptions:"
  echo "  -v <version>  PHP version (required)"
  echo "  -n <name>  Set the project name"
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

echo Uploading Application container 
docker-compose up --build -d

echo Install dependencies
docker run --rm --interactive --tty -v $PWD/projects/$name:/app composer install

echo Copying env variables
docker exec -it php cp /var/www/html/.env.example /var/www/html/.env

echo Laravel Key Generating
docker exec -it php php /var/www/html/artisan key:generate

echo Changing storage permissions
docker exec -it php chmod 777 -R /var/www/html/storage/

echo Information of new containers
docker ps -a 