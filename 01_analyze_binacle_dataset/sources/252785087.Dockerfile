FROM python:3.6  
MAINTAINER Maxime Chéramy <maxime@codingame.com>  
COPY entrypoint.sh /  
COPY build.sh /project/build  
ENTRYPOINT ["/entrypoint.sh"]  

