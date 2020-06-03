FROM alpine  
MAINTAINER Justin Menga <justin.menga@cloudhotspot.co>  
  
RUN apk add --no-cache bash python && \  
apk add --no-cache --virtual=build-dependencies wget ca-certificates && \  
wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python && \  
apk del build-dependencies  
  
RUN pip install --no-cache-dir devpi-server devpi-client devpi-web devpi-ldap  
EXPOSE 3141  
VOLUME ["/var/lib/devpi","/devpi-init.d"]  
COPY entrypoint.sh /usr/bin/entrypoint.sh  
ENTRYPOINT ["entrypoint.sh"]

