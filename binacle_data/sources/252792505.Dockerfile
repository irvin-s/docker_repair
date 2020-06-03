FROM node:8-slim  
  
RUN apt-get update && apt-get install -y cron git  
EXPOSE 80  
# Get flavor-builder  
WORKDIR /git/flavor-builder  
COPY package.json package.json  
RUN npm i && rm -rf /root/.npm /usr/local/share/.cache /root/.cache  
  
COPY crontab /etc/cron.d/flavorbuilder  
RUN chmod 744 /etc/cron.d/flavorbuilder  
RUN touch /var/log/cron.log  
  
COPY start.sh /start.sh  
RUN chmod 744 /start.sh  
  
COPY on-tabs-config.json /on-tabs-config.json  
  
CMD /start.sh  

