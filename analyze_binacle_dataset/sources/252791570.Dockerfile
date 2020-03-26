FROM dahlb/alpine-node  
MAINTAINER Brendan Dahl <dahl.brendan@gmail.com>  
  
COPY / /root/  
  
RUN npm install  
  
CMD ./app.coffee  

