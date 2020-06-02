FROM node:4  
RUN apt-get -y update && \  
apt-get -y install nano ruby sudo && \  
apt-get clean  
  
RUN npm install any2api-cli -g && \  
any2api install scanner all && \  
any2api install invoker all && \  
any2api install generator all  
  
ENTRYPOINT [ "any2api" ]  
CMD [ "--help" ]  

