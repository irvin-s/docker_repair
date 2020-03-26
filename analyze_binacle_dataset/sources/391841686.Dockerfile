FROM nginx:1.15

SHELL ["/bin/bash", "-c"]
COPY /certificates/ /opt/app/
COPY nginx.prod.template /etc/nginx/nginx.prod.template
COPY blockips.conf /etc/nginx/blockips.conf
CMD envsubst '$VIS_INTERNAL_HOST,$VIS_ADMIN_HOSTNAME,$VIS_WEB_SOCKET_ENDPOINT_HOST' < /etc/nginx/nginx.prod.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'