FROM ubuntu:14.04

RUN apt-get upgrade
RUN apt-get update
RUN apt-get -y install software-properties-common curl build-essential
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get -y install git supervisor nginx nodejs
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN echo 55 && git clone --recursive https://github.com/etherdelta/public_api.git
RUN cd /public_api && npm install
RUN cd /public_api/etherdelta.github.io && npm install
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/default /etc/nginx/sites-enabled/default
ADD certs /certs

EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]
