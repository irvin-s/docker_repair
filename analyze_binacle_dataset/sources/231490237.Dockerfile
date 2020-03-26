FROM gitlab/gitlab-runner:latest

RUN apt-get update

RUN export TERM=xterm && apt-get install -y nginx

RUN mkdir /usr/share/nginx/www && mkdir /usr/share/nginx/hom

RUN chown -R gitlab-runner:gitlab-runner /usr/share/nginx/

COPY ./servers.conf /etc/nginx/sites-enabled/servers.conf

COPY ./config.toml /etc/gitlab-runner/config.toml

RUN service nginx restart
