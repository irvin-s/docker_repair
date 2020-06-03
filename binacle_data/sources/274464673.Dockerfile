FROM kyma/docker-nginx

LABEL maintainer "Ridermansb <ridermansb@gmail.com>"

COPY dist/ /var/www/

CMD 'nginx'
