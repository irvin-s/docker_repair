FROM nginx:1.15

SHELL ["/bin/bash", "-c"]
COPY /certificates/ /opt/app/
COPY nginx.template /etc/nginx/nginx.template
CMD envsubst '$PLUGIT_PROXY_HOSTNAME,$VIS_INTERNAL_HOST,$VIS_ADMIN_HOSTNAME,$VIS_WEB_SOCKET_ENDPOINT_HOST' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'
