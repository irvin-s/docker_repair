# DOCKER-VERSION 0.9  
FROM dannycoates/base  
  
RUN apt-get update -y  
RUN apt-get -y install libgmp3-dev  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD docker/confd /etc/confd  
ADD docker/run.sh /etc/service/fxa_auth_server/run  
  
ADD . /app  
WORKDIR /app  
  
RUN npm install  
RUN node scripts/gen_keys.js  
  
# configure the server by overriding these default ENV variables  
ENV AUTH_MAIL_HOST 172.17.42.1  
ENV AUTH_MAIL_PORT 25  
ENV AUTH_MAIL_SENDER Firefox Accounts <verification@dcoates.dev.lcip.org>  
ENV AUTH_PUBLIC_URL https://dcoates.dev.lcip.org/auth  
ENV AUTHDB_PRIVATE_URL http://172.17.42.1:8000  
ENV CONTENT_PUBLIC_URL https://dcoates.dev.lcip.org  
ENV CUSTOMS_PRIVATE_URL http://172.17.42.1:7000  
ENV DOMAIN_NAME dcoates.dev.lcip.org  
  
EXPOSE 9000  

