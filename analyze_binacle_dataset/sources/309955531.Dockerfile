FROM nginx
ARG PROJECT=laravel5
WORKDIR /var/www/${PROJECT}/public
COPY public /var/www/${PROJECT}/public
