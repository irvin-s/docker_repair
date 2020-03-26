FROM node:6  
# Create app directory  
RUN mkdir -p /app  
WORKDIR /app  
  
# Variables  
ENV PORT 8080  
ENV DB_STORAGE database.sqlite  
  
# Install  
COPY ./src /app  
COPY config-docker.json /app/config.json  
RUN npm install .  
  
#Image configuration  
ADD start.sh /start.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 8080  
CMD ["/start.sh"]  

