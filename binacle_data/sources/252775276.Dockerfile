FROM node:slim  
  
RUN \  
npm install -g nodemon && \  
npm cache clear && \  
rm -rf /tmp/* && rm -rf /var/tmp/* && rm -rf /var/lib/apt/list/*  
  
EXPOSE 3000  
VOLUME /app  
WORKDIR /app  
  
CMD ["bash"]  

