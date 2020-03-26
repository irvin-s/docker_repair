FROM alpine:edge  
  
# acme.sh environment variables  
ENV LE_CONFIG_HOME /etc/letsencrypt  
ENV LE_WORKING_DIR /etc/letsencrypt  
  
# Install needed packages  
RUN apk add --update --no-cache --no-progress bash git openssl sed wget \  
&& git clone https://github.com/Neilpang/acme.sh.git /tmp/acme.sh/ \  
&& cd /tmp/acme.sh/ && /tmp/acme.sh/acme.sh --install --log /dev/stdout \  
&& rm -rf /tmp/acme.sh/ \  
&& apk del git \  
&& rm -rf /var/cache/apk/*  
  
COPY ./assets/docker-entrypoint.sh /usr/local/bin/  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["/usr/bin/env","/usr/sbin/crond", "-f","-d","8"]  

