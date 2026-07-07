FROM php:8.1-apache

# Instalar dependencias necesarias para PrestaShop
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    unzip \
    wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install zip gd pdo_mysql mysqli opcache

# Habilitar el módulo rewrite de Apache
RUN a2enmod rewrite

# Descargar e instalar PrestaShop de forma directa
WORKDIR /var/www/html
RUN wget https://github.com/PrestaShop/PrestaShop/releases/download/8.1.2/prestashop_8.1.2.zip \
    && unzip prestashop_8.1.2.zip \
    && unzip prestashop.zip \
    && rm prestashop_8.1.2.zip prestashop.zip index.php \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
