# Add PHP-FPM base image
FROM php:8.3-fpm

# Update dependencies
RUN apt-get update \
# Install Zip
    && apt-get install -y libzip-dev zip \
    && docker-php-ext-install zip \
# Install Git
    && apt-get install -y git \
# Install Curl
    && apt-get install -y libcurl3-dev curl \
    && docker-php-ext-install curl \
# Install procps (required by Octane)
    && apt-get install -y procps \
# Install EXIF
    && docker-php-ext-install exif \
# Install GD
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
# Install MySQL
    && docker-php-ext-install pdo pdo_mysql \
# Install BC Math
    && docker-php-ext-install bcmath \
# Install internationalization functions
    && apt-get install -y zlib1g-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
# Install Node (v16 LTS) (required by Octane)
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs supervisor \
# Install NPM (required by Octane)
    && npm install -g npm \
# Clean up the apt cache
    && rm -rf /var/lib/apt/lists/*

# Copy PHP configuration
COPY php.ini "/usr/local/etc/php/php.ini"

# Specify the node path (allow including Chokidar lib globally)
ENV NODE_PATH /usr/lib/node_modules

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Configure non-root user.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

WORKDIR /var/www/html/public
RUN chown -R www-data:www-data /var/www/
RUN chown -R www-data:www-data /var/www/html/public

WORKDIR /var/www/html
