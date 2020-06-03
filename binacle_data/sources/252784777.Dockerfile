FROM node:6  
# Create sentimeter directory  
RUN mkdir /water-api  
WORKDIR /water-api  
  
# Variables  
ENV NODE_ENV production  
ENV MONGO_SERVER localhost  
ENV DB_PREFIX tw  
ENV SECRET hush_hush  
ENV LOGGING false  
  
# Install  
COPY . /water-api  
  
RUN npm install .  
  
COPY config-docker.json /water-api/config/config.json  
# Add image configuration and scripts  
COPY start.sh /start.sh  
RUN chmod 755 /*.sh  
EXPOSE 8080  
CMD ["/start.sh"]  

