FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y ruby1.9.3 bundler

RUN echo 'export PATH="/var/www/html/.ruby-gems/1.9.3/bin:$PATH"' >> /etc/profile
RUN echo 'export GEM_HOME="/var/www/html/.ruby-gems/1.9.3"' >> /etc/profile
RUN mkdir -p /var/www/.bundler

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
