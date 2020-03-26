# This dockerfile is used to run the autostew backend service  
FROM ubuntu:14.04  
Maintainer Michael Wittig <witmic1@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV DJANGO_SETTINGS_MODULE=autostew.settings.prod  
ENV BRANCH=master  
ENV SERVER_ID=1  
COPY dependencies.sh dependencies.sh  
  
# install all dependencies  
RUN ./dependencies.sh $BRANCH  
  
COPY run_autostew_back.sh autostew/run_autostew_back.sh  
  
WORKDIR /autostew  
VOLUME ["autostew/settings"]  
  
CMD ./run_autostew_back.sh $BRANCH $SERVER_ID  

