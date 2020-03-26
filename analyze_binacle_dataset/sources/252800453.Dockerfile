FROM node:6.9  
MAINTAINER Dom & Tom Inc. <hello@domandtom.com>  
  
WORKDIR /data/src  
  
ENV NODE_ENV production \  
PORT 80  
EXPOSE 80  
CMD ["node", "index.js"]  
  
RUN apt-get update \  
&& apt-get install -y \  
apt-transport-https \  
&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg \  
| apt-key add - \  
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" \  
| tee /etc/apt/sources.list.d/yarn.list \  
&& apt-get update \  
&& apt-get install -y \  
yarn \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

