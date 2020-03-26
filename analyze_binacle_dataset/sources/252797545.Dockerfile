FROM node:8.4-alpine  
  
ADD . /app  
  
RUN cd /app && \  
npm install pm2 -g && \  
npm install mini-proxy && \  
chmod +x /app/entrypoint.sh  
  
WORKDIR /app  
CMD ["/app/entrypoint.sh"]  

