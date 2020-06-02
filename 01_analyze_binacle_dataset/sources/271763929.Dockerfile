FROM nginx:1.14
LABEL maintainer="shirakiya"

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/jaaxman.prod.conf /etc/nginx/conf.d/jaaxman.conf
# for static files
COPY ./app /app/app

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean

RUN rm /etc/nginx/conf.d/default.conf \
    && mkdir -p /var/log/nginx/jaaxman \
    && touch /var/log/nginx/jaaxman/access.log \
    && touch /var/log/nginx/jaaxman/error.log \
    && ln -sf /dev/stdout /var/log/nginx/jaaxman/access.log \
    && ln -sf /dev/stderr /var/log/nginx/jaaxman/error.log
