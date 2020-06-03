FROM node  
  
ENV APP_ROOT /retool_backend  
  
ARG ENV_FILE  
  
# Set up Hammerhead  
COPY . $APP_ROOT/  
COPY $ENV_FILE $APP_ROOT/.env  
  
WORKDIR /retool_backend  
  
RUN yarn install  
RUN yarn global add sequelize-cli  
  
EXPOSE 3000  
EXPOSE 3001  
EXPOSE 3002  

