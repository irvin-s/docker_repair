FROM node:6  
# Create sentimeter directory  
RUN mkdir /operator-api  
WORKDIR /operator-api  
  
# Variables  
ENV NODE_ENV production  
ENV DATABASE_HOST localhost  
ENV DATABASE_NAME operator_db  
ENV DATABASE_USER postgres  
#ENV DATABASE_PASSWORD  
ENV DATABASE_PORT 5432  
ENV LOGGING false  
  
# Install  
COPY . /operator-api  
  
RUN npm install .  
COPY config/config.docker.json /operator-api/config/config.json  
  
# Add image configuration and scripts  
ADD start.sh /start.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 8080  
CMD ["/start.sh"]  

