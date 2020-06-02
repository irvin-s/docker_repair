FROM tmaier/docker-compose:latest  
  
RUN apk update && apk add nodejs  
RUN npm install -g heroku  
RUN heroku plugins:install heroku-container-registry  

