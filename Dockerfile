FROM php:8.1-apache

# Instalar dependencias del sistema y la herramienta Composer
RUN apt-get update && apt-get install -y \
    libzip-dev libpng-dev libjpeg-dev \
    libwebp-dev libfreetype6-dev git unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install zip gd pdo_mysql mysqli \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Habilitar el módulo rewrite de Apache
RUN a2enmod rewrite

# Clonar PrestaShop e instalar sus dependencias de desarrollo de forma automática
WORKDIR /var/www/html
RUN git clone --depth=1 https://github.com/PrestaShop/PrestaShop.git . \
    && composer install --no-dev --prefer-dist --no-scripts --no-progress \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
