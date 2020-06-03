FROM debian:jessie

RUN apt-get update
RUN apt-get install -y curl

WORKDIR /tmp

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs build-essential

WORKDIR /var/www/site

CMD ["sh", "docker/init-vm.sh"]
