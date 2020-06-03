FROM mhart/alpine-node  
  
COPY . docker/config.json /app/  
  
ENV PORT="1999"  
RUN mkdir /data \  
&& cd /app \  
&& npm install  
  
EXPOSE 1999 2000  
WORKDIR /app  
  
CMD ["node", "storage.js"]  

