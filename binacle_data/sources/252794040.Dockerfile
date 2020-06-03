FROM node:6  
ARG PACKAGIST_USER=""  
ENV PACKAGIST_USER $PACKAGIST_USER  
  
ARG PACKAGIST_TOKEN=""  
ENV PACKAGIST_TOKEN $PACKAGIST_TOKEN  
  
ARG PACKAGIST_URL="https://packagist.org"  
ENV PACKAGIST_URL $PACKAGIST_URL  
  
ARG APP_PORT=80  
ENV APP_PORT $APP_PORT  
  
ARG WEBHOOK_TOKEN=""  
ENV WEBHOOK_TOKEN $WEBHOOK_TOKEN  
  
EXPOSE $APP_PORT  
  
RUN apt-get update  
RUN apt-get -y install unzip  
RUN mkdir -p /opt  
  
WORKDIR /opt  
  
RUN wget https://github.com/darneta/rpwm/archive/master.zip  
RUN unzip master.zip  
RUN mv rpwm-master app  
RUN rm master.zip  
  
WORKDIR /opt/app  
  
RUN npm install && npm cache clean --force  
  
CMD [ "node", "server.js" ]  

