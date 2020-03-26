FROM digitaldrummerj/cordova  
  
MAINTAINER Justin James <digitaldrummerj@gmail.com>  
  
  
# IONIC  
WORKDIR "/tmp"  
  
RUN npm i -g --unsafe-perm ionic  
  
#ENV IONIC_VERSION latest  
#RUN npm i -g --unsafe-perm ionic@${IONIC_VERSION}  

