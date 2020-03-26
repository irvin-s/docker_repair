FROM nginx:1.11.3  
MAINTAINER benileo "yew@alltree.ca"  
RUN rm /etc/nginx/conf.d/default.conf  
  
RUN set -e \  
&& openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 \  
&& mkdir /etc/nginx/ssl \  
&& openssl req -x509 -nodes \  
-days 3650 \  
-newkey rsa:4096 \  
-subj /CN=selfsigned \  
-keyout /etc/nginx/ssl/nginx.key \  
-out /etc/nginx/ssl/nginx.crt  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
curl  
  
ENV CERTBOT_VERSION 0.9.3  
ENV BASE_URL https://github.com/certbot/certbot/archive/v  
  
WORKDIR /opt/certbot  
  
RUN set -e \  
&& curl -sL "${BASE_URL}${CERTBOT_VERSION}.tar.gz" | tar xzf - \  
&& cd "certbot-${CERTBOT_VERSION}" \  
&& ./certbot-auto --os-packages-only --non-interactive \  
&& curl -sL https://bootstrap.pypa.io/get-pip.py | python \  
&& pip install acme certbot  
  
RUN set -e \  
&& apt-get remove -y --purge curl \  
&& apt-get autoremove -y \  
&& apt-get clean \  
&& rm -rf \  
/var/lib/apt/lists/* \  
/tmp/* \  
/var/tmp/*  
  
COPY entrypoint.py .  
ENTRYPOINT [ "./entrypoint.py" ]

