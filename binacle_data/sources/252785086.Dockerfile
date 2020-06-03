FROM node:7.4  
MAINTAINER Julien Poulton <julien@codingame.com>  
COPY entrypoint.sh /  
COPY build.sh /project/build  
ENTRYPOINT ["/entrypoint.sh"]  

