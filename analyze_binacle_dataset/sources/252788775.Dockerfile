FROM node:6  
MAINTAINER Yafeng Shan <yafeng.shan@gmail.com>  
  
WORKDIR /blog  
  
RUN npm install hexo-cli -g  
RUN apt-get update && apt-get install -y rsync && apt-get clean  
  
EXPOSE 4000  
CMD ["hexo", "server","-i","0.0.0.0"]  

