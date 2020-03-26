FROM openjdk:8-jre-alpine  
  
COPY shortener.jar /  
COPY shortener.sh /usr/bin/shortener  
COPY bitly.sh /usr/bin/bitly  
COPY googl.sh /usr/bin/googl  
  
RUN chmod +x /usr/bin/shortener \  
&& chmod +x /usr/bin/bitly \  
&& chmod +x /usr/bin/googl  
  
WORKDIR /  
ENTRYPOINT /bin/sh  

