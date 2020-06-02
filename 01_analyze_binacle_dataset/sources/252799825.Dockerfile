FROM digitaldrummerj/android-nodejs  
  
MAINTAINER Justin James <digitaldrummerj@gmail.com>  
  
  
  
# IONIC  
WORKDIR "/tmp"  
  
RUN npm i -g --unsafe-perm cordova bower gulp-cli  
  
#ENV CORDOVA_VERSION 6.1.1  
#RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION}  

