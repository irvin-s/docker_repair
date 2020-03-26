FROM node:latest  
MAINTAINER davyyy, dawei.si@qq.com  
  
# install hexo  
RUN npm install hexo-cli -g  
  
# init  
WORKDIR _init  
RUN hexo init && npm install  
  
# create data volume  
VOLUME /blog  
WORKDIR /blog  
  
# hexo default port  
EXPOSE 4000  
# set entrypoint  
COPY entrypoint.sh /root/  
RUN chmod +x /root/entrypoint.sh  
  
# run hexo server  
ENTRYPOINT ["/root/entrypoint.sh"]  

