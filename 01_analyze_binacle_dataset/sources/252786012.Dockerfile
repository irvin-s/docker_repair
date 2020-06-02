# Experiment with making node.js apps and docker with links playing nicely!  
FROM node  
  
MAINTAINER Daryl Kranec  
  
run mkdir /keystone  
  
VOLUME ["/keystone"]  
  
RUN cd base; npm install  
  
RUN cd keystone; ls ./  
  
EXPOSE 3000  
CMD ["node","keystone.js"]  

