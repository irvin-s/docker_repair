FROM mongo  
RUN mkdir -p /data/db  
RUN mkdir -p /var/log/mongodb  
ADD mongodb.conf /etc/mongodb.conf  
VOLUME ["/data/db",/var/log/mongodb]  
# Expose ports.  
# - 27017: process  
# - 28017: http  
#EXPOSE 27017  
#EXPOSE 28017  
CMD ["mongod"]  
  

