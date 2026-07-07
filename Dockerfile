FROM prestashop/prestashop:8.1-apache

RUN sed -i 's/exec "$@"/# exec "$@"/g' /tmp/docker_run.sh

RUN chown -R www-data:www-data /var/www/html
