# Use the official PHP image with Laravel support
FROM php:8.3.14-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    npm \
    net-tools \
    supervisor \
    && mkdir -p /var/log/supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && pecl install redis \
    && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Start the PHP-FPM server
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-F"]
