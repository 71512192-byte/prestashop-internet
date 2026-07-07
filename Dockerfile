FROM php:8.1-apache

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev libpng-dev libjpeg-dev \
    libwebp-dev libfreetype6-dev git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install zip gd pdo_mysql mysqli

# Habilitar el módulo rewrite de Apache
RUN a2enmod rewrite

# Clonar PrestaShop directamente (gasta menos memoria que descomprimir)
WORKDIR /var/www/html
RUN git clone --depth=1 https://github.com/PrestaShop/PrestaShop.git . \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
