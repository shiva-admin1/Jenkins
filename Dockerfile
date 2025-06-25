# Use the official PHP image as a base
FROM php:8.1.30-zts-bookworm

# Install required dependencies and PHP extensions
RUN apt-get update && apt-get install -y
    curl
    ca-certificates
    git
    zip
    unzip
    libzip-dev
    libonig-dev
    libpng-dev
    && docker-php-ext-install zip pdo pdo_mysql mbstring exif pcntl bcmath gd
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .
#custom php.ini
COPY custom-php.ini /usr/local/etc/php/conf.d

# Install application dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set appropriate permissions for Laravel storage and cache
RUN chown -R www-data:www-data /var/www
    && chmod -R 755 /var/www/storage
    && chmod -R 755 /var/www/bootstrap/cache

# Expose port 9000 for PHP-FPM
EXPOSE 7000

ENV UPLOAD_MAX_FILESIZE=5M


# Start Laravel application (for development)
CMD ["php", "./artisan", "serve", "--host=0.0.0.0", "--port=7000"]

