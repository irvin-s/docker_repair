FROM node:6-alpine  
  
RUN apk update && apk add --no-cache curl  
  
ENV SECRET_TOKEN="somesupersecret"  
ENV SUBDOMAIN="mysubdomain"  
ENV ICLOUDUSER="me@mac.com"  
ENV ICLOUDPASS="mypassword"  
COPY package.json package.json  
  
RUN npm install && \  
rm -rf /tmp/* /root/.npm  
  
COPY . .  
  
USER node  
  
EXPOSE 8080  
HEALTHCHECK \--interval=1m --timeout=2s \  
CMD curl -LSs http://localhost:8080 || exit 1  
  
CMD npm start  

