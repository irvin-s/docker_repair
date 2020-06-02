FROM ahwebd/stools  
  
USER root  
  
# Nodejs  
# check polymer-cli requirements for nodejs version  
# https://www.polymer-project.org/2.0/docs/tools/node-support  
RUN set -ex \  
&& curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \  
&& apt-get install -y nodejs \  
&& rm -rf /var/lib/apt/lists/*  
# npm, bower, polymer-cli  
RUN set -ex \  
&& npm install -g bower \  
&& npm install -g polymer-cli  
  
USER dkr  

