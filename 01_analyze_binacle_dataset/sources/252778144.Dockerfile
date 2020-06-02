#  
# Tau User Interface Docker File  
#  
# tau-ui is the static html, css, and javascript for the Tau application  
# https://github.com/appliedis/tau-ui  
#  
#  
FROM node:8.5.0  
MAINTAINER Tau Developers <https://github.com/appliedis/tau-ui>  
  
WORKDIR /tau  
  
ADD . /tau  
  
# Build the static deployment site  
RUN npm install && \  
npm run deploy  
  
FROM nginx:alpine  
MAINTAINER Tau Developers <https://github.com/appliedis/tau-ui>  
  
# copy the artifacts from the first stage into Nginx  
COPY \--from=0 /tau/dist /usr/share/nginx/html  
COPY \--from=0 /tau/docker /usr/share/nginx/html/docker  
  
# Run startup script  
RUN apk add --no-cache bash jq && \  
chmod +x /usr/share/nginx/html/docker/*.sh  
  
CMD ["/usr/share/nginx/html/docker/start.sh"]  

