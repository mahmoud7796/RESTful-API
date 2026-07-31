FROM php:8.3-fpm-alpine

RUN apk add --no-cache git unzip libzip-dev icu-dev \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && docker-php-ext-install pdo_mysql bcmath opcache pcntl zip \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl clear-cache \
    && apk del .build-deps

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN addgroup -g 1000 appuser \
    && adduser -D -u 1000 -G appuser appuser \
    && chown -R appuser:appuser /var/www/html

WORKDIR /var/www/html

USER appuser