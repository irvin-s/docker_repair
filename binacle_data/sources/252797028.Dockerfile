FROM node:4.1.2  
WORKDIR /root  
RUN npm install cloudcmd  
  
# replace this with your application's default port  
EXPOSE 8000  
# replace this with your main "server" script file  
CMD [ "node", "node_modules/cloudcmd/bin/cloudcmd.js" ]  

