# Esto es para obtener la variable DOCKERHOST.
# En caso de querer escalar el servicio usando 'scale', el nombre
# ya no es válido.
export DOCKERHOST=$(docker exec praxya_odoo_10 netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
docker-compose -f docker-compose.yml up -e DOCKERHOST=$DOCKERHOST
