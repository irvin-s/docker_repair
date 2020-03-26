FROM mongo:3.2  
RUN apt-get -y update && apt-get -y install netcat vim-tiny  
  
ADD mongod.conf /etc/mongod.conf  
ADD mongos.conf /etc/mongos.conf  
ADD mongoc.conf /etc/mongoc.conf  
ADD run.sh /app/run.sh  
ADD mongos.sh /app/mongos.sh  
ADD mongod.sh /app/mongod.sh  
ADD mongoc.sh /app/mongoc.sh  
ADD keyfile /app/keyfile  
RUN chmod 600 /app/keyfile  
ADD createClusterAdmin.js /app/createClusterAdmin.js  
ADD createAdmin.js /app/createAdmin.js  
CMD ["bash","/app/run.sh"]  

