FROM keymetrics/pm2:latest  
  
# Bundle APP files  
WORKDIR /app  
COPY ./ ./  
  
# Install app dependencies  
ENV NPM_CONFIG_LOGLEVEL warn  
RUN yarn install --frozen-lockfile --no-cache --production  
  
# Show current folder structure in logs  
RUN ls -al  
  
#CMD [ "ping google.com" ]  
CMD [ "pm2-docker", "start", "pm2.json" ]

