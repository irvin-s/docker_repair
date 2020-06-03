FROM node:0.12.7  
WORKDIR /var/cache/drone/src/src-tms.als.local/frontend/marketplace-base  
ADD . /var/cache/drone/src/src-tms.als.local/frontend/marketplace-base  
RUN npm install -g bower gulp  
RUN npm install  
RUN bower install --allow-root  

