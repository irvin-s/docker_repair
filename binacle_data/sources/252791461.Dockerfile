FROM centos:latest  
MAINTAINER dadait <web3.0@qq.com>  
  
COPY ["srs", "entrypoint.sh", "/"]  
EXPOSE 1935 1985 8080  
ENTRYPOINT ["/entrypoint.sh"]  

