FROM node  
  
MAINTAINER Yehuda Deutsch <yeh@uda.co.il>  
  
RUN npm install -g redis-commander  
  
EXPOSE 8081  
ENTRYPOINT ["redis-commander"]  

