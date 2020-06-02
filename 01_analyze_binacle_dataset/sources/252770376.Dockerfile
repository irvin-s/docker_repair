FROM ashtreecc/android:24.4.1  
MAINTAINER Andrew Nash "akahadaka@gmail.com"  
RUN npm install nativescript -g --unsafe-perm  
  
# Accept the licence agreement  
RUN echo Y | tns info  
  
VOLUME /src  
WORKDIR /src  
  

