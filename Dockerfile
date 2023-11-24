FROM php:8.1-apache

# Install required PHP extensions and dependencies
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        libmemcached-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        unzip \
        git \
        vim \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
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
    && a2dissite 000-default.conf \
    && a2dissite default-ssl.conf

# Copy website files
WORKDIR /var/www/html
COPY --chown=www-data:www-data ./site-1 site-1/
COPY --chown=www-data:www-data ./site-2 site-2/

# Allow RW permissions to all users in the container
RUN chmod -R 755 /var/www

EXPOSE 80

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh
ENTRYPOINT ["/usr/local/bin/init.sh"]

# Use non-root user
USER www-data