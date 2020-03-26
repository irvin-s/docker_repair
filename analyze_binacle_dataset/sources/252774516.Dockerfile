FROM mhart/alpine-node:6  
MAINTAINER Ashley Murphy <irashp@gmail.com>  
  
WORKDIR /node-run  
  
COPY startup.sh /startup.sh  
ENTRYPOINT ["/startup.sh"]  

