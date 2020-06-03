FROM node:5.0  
COPY . /root/  
RUN cd /root/; npm install --production  
EXPOSE 3000  
CMD ["node", "/root/app.js"]  

