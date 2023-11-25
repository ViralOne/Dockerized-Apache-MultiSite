FROM php:8.2-apache

# Install required PHP extensions and dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        libzip-dev \
        libpng-dev \
        libzip-dev \
        unzip \
        git \
        vim \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        gd \
        zip \
        mysqli \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy Apache site configurations
COPY ./configs/ /etc/apache2/sites-available/

# Enable & disable site configurations
RUN a2ensite *.conf \
    && a2dissite 000-default.conf default-ssl.conf

# Use non-root user
USER www-data

# Copy submodules into /var/www/html
WORKDIR /var/www/html
COPY ./site-1 site-1/
COPY ./site-2 site-2/

EXPOSE 80
