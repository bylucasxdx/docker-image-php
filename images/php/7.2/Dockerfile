FROM php:7.2-fpm-alpine

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# lumen packages
RUN docker-php-ext-install mbstring tokenizer mysqli pdo_mysql

RUN apk add icu-dev 
RUN docker-php-ext-configure intl && docker-php-ext-install intl