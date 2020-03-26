FROM 1and1internet/debian-9-nginx  
MAINTAINER brian.wilkinson@1and1.co.uk  
COPY files/ /  
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \  
&& apt-get update \  
&& apt-get install -y gnupg curl telnet \  
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
&& apt-get install -y nodejs \  
&& node -v \  
&& npm install -g mongo-express \  
&& cd /usr/lib/node_modules/mongo-express \  
&& cp config.default.js config.js \  
&& apt-get remove gnupg \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& chmod 666 /etc/nginx/sites-enabled/site.conf \  
&& chmod -R 777 /etc/supervisor/conf.d \  
&& chmod +x /init/supervisord-pre  
  
ENV ME_CONFIG_MONGODB_ADMINUSERNAME="defaultadminuser" \  
ME_CONFIG_MONGODB_ADMINPASSWORD="defaultadminpass" \  
ME_CONFIG_MONGODB_ENABLE_ADMIN=true \  
ME_CONFIG_BASICAUTH_USERNAME="baUser" \  
ME_CONFIG_BASICAUTH_PASSWORD="baPass" \  
ME_CONFIG_MONGODB_AUTH_DATABASE=admin  
  
CMD /init/supervisord-pre  

