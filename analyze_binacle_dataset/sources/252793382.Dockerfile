FROM danshan/shanhh-docker  
MAINTAINER i@shanhh.com  
  
  
ADD jekyll /opt/data/jekyll  
ADD qiniu /opt/data/qiniu  
RUN mkdir -p /var/log/qiniu  
  
ADD bin/entrypoint.sh /opt/data/entrypoint.sh  
  
WORKDIR /opt/data/jekyll  
  
EXPOSE 4000  
ENTRYPOINT ["/opt/data/entrypoint.sh"]

