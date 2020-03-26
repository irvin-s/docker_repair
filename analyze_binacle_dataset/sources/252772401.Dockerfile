FROM node:5.3.0  
RUN npm install -g wait-for-cassandra  
RUN npm install -g wait-for-mysql  
RUN npm install -g wait-for-postgres  
RUN npm install -g wait-for-redis  

