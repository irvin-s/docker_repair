# http://codepany.com/blog/rails-5-and-docker-puma-nginx/
FROM nginx

ENV RAILS_ROOT /data/src/

RUN apt-get update -qq && apt-get -y install apache2-utils

WORKDIR $RAILS_ROOT

RUN mkdir log public

COPY docker/nginx.conf /tmp/docker.nginx

RUN envsubst '$RAILS_ROOT' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
