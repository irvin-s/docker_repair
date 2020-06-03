FROM node:0.10  
ADD worker.js /opt/worker.js  
WORKDIR /opt/  
ENTRYPOINT ["node", "worker.js"]  

