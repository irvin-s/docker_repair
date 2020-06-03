FROM mhart/alpine-node:4  
COPY . /opt/app/  
  
WORKDIR /opt/app  
  
EXPOSE 3000  
ENV PORT=3000  
CMD ["node", "server.js"]  

