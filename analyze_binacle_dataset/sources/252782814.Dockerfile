FROM node:6.11.1-slim  
  
USER root  
  
RUN npm install -g ionic@2.1.18  
RUN apt-get update && apt-get install -y screen \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /var/app_content  
EXPOSE 8100  
COPY ./docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

