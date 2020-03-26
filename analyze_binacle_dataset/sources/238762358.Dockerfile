FROM kyma/docker-nginx
COPY ./frontend/public /var/www
CMD 'nginx'