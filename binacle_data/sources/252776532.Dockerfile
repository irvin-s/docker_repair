FROM node:8-slim  
  
RUN npm i -g coin-hive-stratum --unsafe-perm=true \--allow-root  
  
ENTRYPOINT ["coin-hive-stratum"]

