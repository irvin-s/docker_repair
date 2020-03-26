FROM mongo:3.4  
MAINTAINER Daniel Phillips (http://danp.us)  
  
# timezone  
RUN echo "Etc/UTC" > /etc/timezone && \  
dpkg-reconfigure -f noninteractive tzdata  
  
COPY replInit.sh /replInit.sh  
COPY mongo.sh /mongo.sh  
RUN chmod 755 /replInit.sh  
RUN chmod 755 /mongo.sh  
  
CMD ["/mongo.sh"]  

