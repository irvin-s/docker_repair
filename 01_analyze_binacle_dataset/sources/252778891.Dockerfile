FROM ghost:1.19.0-alpine  
LABEL maintainer="JD Courtoy <docker@courtoy.io>"  
  
COPY ./src/content /var/lib/ghost/content  
  
RUN npm i -g nodemon  

