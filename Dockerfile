FROM prestashop/prestashop:8.1.1-apache

# Corregimos el script interno para que Render no falle con el error 127
ENTRYPOINT ["/bin/bash", "-c", "sed -i 's/exec \"\$@\"/# exec \"\$@\"/g' /tmp/docker_run.sh && /tmp/docker_run.sh apache2-foreground"]
