FROM node:6  
# Create sentimeter directory  
RUN mkdir -p /sentimeter/data  
WORKDIR /sentimeter  
  
# Variables  
ENV NODE_ENV production  
ENV DATABASE_HOST localhost  
ENV DATABASE_NAME application  
ENV DATABASE_USER root  
ENV DATABASE_PASSWORD root  
ENV DATABASE_PORT 3306  
ENV DATABASE_DIALECT mysql  
ENV DATABASE_STORAGE ./production.sentimeter.sqlite  
ENV LOGGING false  
  
# Install  
COPY . /sentimeter  
  
RUN npm install .  
RUN npm install sequelize-cli  
RUN node_modules/.bin/sequelize db:migrate  
# RUN ls -la node_modules/.bin  
# COPY config-docker.json /sentimeter/config/config.json  
VOLUME /sentimeter/data  
  
EXPOSE 8080  
CMD ["node", "index.js"]  

