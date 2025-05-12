# === STAGE 1: Build Assets ===
FROM node:18 AS node-builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# === STAGE 2: PHP + Composer ===
FROM php:8.2-fpm AS php-builder

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    git curl zip unzip libzip-dev libpng-dev libonig-dev libxml2-dev \
    libjpeg-dev libfreetype6-dev cron supervisor \
    && docker-php-ext-configure gd \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

# Copy built assets from Node stage
COPY --from=node-builder /app/public /var/www/public

RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

# === FINAL STAGE ===
FROM php:8.2-fpm

WORKDIR /var/www

COPY --from=php-builder /var/www /var/www
COPY --from=php-builder /usr/bin/composer /usr/bin/composer
COPY --from=php-builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=php-builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Install Nginx and cron
RUN apt-get update && apt-get install -y nginx cron supervisor \
    && mkdir -p /run/php

COPY deploy/nginx.conf /etc/nginx/conf.d/default.conf

# Entry scripts
COPY deploy/entrypoint.sh /entrypoint.sh
#COPY deploy/queue.sh /queue.sh
#COPY deploy/scheduler.sh /scheduler.sh
RUN #chmod +x /entrypoint.sh /queue.sh /scheduler.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
