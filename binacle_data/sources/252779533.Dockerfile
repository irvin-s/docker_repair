# Empezamos usando node version 6.  
FROM node:boron  
  
# Instalamos git para poder usar bower.  
# instalamos bower  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y git --no-install-recommends \  
&& rm -rf /var/lib/apt/lists/* \  
&& npm install -g bower  

