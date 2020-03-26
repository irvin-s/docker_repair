FROM node:latest  
MAINTAINER Brandon Papworth <brandon@papworth.me>  
  
RUN apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg \  
&& echo "deb http://dl.yarnpkg.com/debian/ stable main" | \  
tee /etc/apt/sources.list.d/yarn.list \  
&& apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install -y yarn \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

