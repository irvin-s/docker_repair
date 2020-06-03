FROM node:4  
RUN npm install npm@latest -g  
RUN npm cache clean -f  
RUN npm install -g n  
RUN n stable  
RUN npm install express  
RUN npm install xml2js  
RUN npm install neo4j-driver  
RUN npm install sleep  
#webserverport  
EXPOSE 80  
CMD ["/bin/bash"]  

