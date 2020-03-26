FROM mongo:3.2.18  
ADD mongod.conf /etc/  
  
EXPOSE 27017 28017  
CMD exec mongod -f /etc/mongod.conf  
  

