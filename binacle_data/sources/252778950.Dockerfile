FROM node:7  
ENV NODE_PATH=/usr/local/lib/node_modules  
COPY . /app  
RUN cd /app && npm install  
RUN chmod a+x /app/start.sh  
  
EXPOSE 80  
WORKDIR /app  
CMD ["/app/start.sh"]  

