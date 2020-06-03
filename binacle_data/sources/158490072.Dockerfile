FROM debian:jessie

MAINTAINER Maxence POUTORD <maxence.poutord@gmail.com>

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/
ADD codelabs.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/codelabs.conf /etc/nginx/sites-enabled/codelabs
RUN rm /etc/nginx/sites-enabled/default

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
