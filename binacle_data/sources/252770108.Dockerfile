FROM node:latest  
RUN mkdir /var/db  
WORKDIR /var/db  
RUN cd /var/db && npm init -f && npm install dabby mysql express --save  
EXPOSE 7001  
CMD ["node", "/var/db/node_modules/dabby/bin", "-a", "7001"]

