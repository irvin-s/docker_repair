FROM aspirinsjl/genieacs  
  
# GenieACS will be listening to 0.0.0.0:7547  
EXPOSE 7547  
# Learn from truongsinh/nodejs-mongodb-redis  
# For MongoDB, .conf should be specified to avoid using /data/db path  
## --smallfiles should be added to avoid the insufficient journal space issue  
CMD mongod --fork -f /etc/mongod.conf --smallfiles&& \  
redis-server /etc/redis/redis.conf && \  
genieacs-cwmp && \  
bash

