FROM nginx:stable

VOLUME /etc/letsencrypt

EXPOSE 80
EXPOSE 443

ARG SERVER_NAME
ARG REDIRECT_DOMAINS
ARG HTTPS_CERT_NAME
ARG FAKE_HOSTS

RUN apt-get update && apt install -y wget ruby cron && wget https://dl.eff.org/certbot-auto -O /certbot-auto && chmod +x ./certbot-auto

ADD ./config/crontab /certcrontab
ADD ./scripts/updatecerts.sh /
ADD ./scripts/entrypoint.sh /

ADD ./config/nginx.conf.erb /tmp
RUN SERVER_NAME=$SERVER_NAME \
    REDIRECT_SERVER_NAMES=$REDIRECT_DOMAINS \
    HTTPS_CERT_NAME=$HTTPS_CERT_NAME \
    FAKE_HOSTS=$FAKE_HOSTS \
    erb -T - /tmp/nginx.conf.erb > /etc/nginx/nginx.conf
RUN FAKE_HOSTS=$REDIRECT_DOMAINS \
    erb -T - /tmp/nginx.conf.erb > /etc/nginx/nginx.conf.fake

RUN chmod +x /updatecerts.sh
RUN chmod +x /entrypoint.sh
RUN usermod -u 1000 www-data
RUN mkdir -p /var/wwwnossl

# uncomment me for lighter container and slower build
# RUN apt-get purge   -y ruby
RUN rm /tmp/nginx.conf.erb

ENTRYPOINT /entrypoint.sh

