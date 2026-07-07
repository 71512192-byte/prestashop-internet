FROM php:8.1-apache

# 1. Instalar las extensiones que necesita PrestaShop para funcionar
RUN apt-get update && apt-get install -y \
    libzip-dev libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev unzip wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install zip gd pdo_mysql mysqli

# 2. Habilitar la reescritura de URLs para Apache
RUN a2enmod rewrite

# 3. Descargar el PrestaShop oficial ya listo para instalar (sin pasar por Git)
WORKDIR /var/www/html
RUN wget https://github.com/PrestaShop/PrestaShop/releases/download/8.1.2/prestashop_8.1.2.zip \
    && unzip prestashop_8.1.2.zip -d /tmp/prestashop_extracted \
    && unzip /tmp/prestashop_extracted/prestashop.zip -d /var/www/html \
    && rm -rf prestashop_8.1.2.zip /tmp/prestashop_extracted index.php \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
