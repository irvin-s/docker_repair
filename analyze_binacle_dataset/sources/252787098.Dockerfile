FROM dockerfile/nodejs:latest  
  
# App  
ADD . /src  
# Install app dependencies  
RUN cd /src; npm install  
  
EXPOSE 80  
CMD ["node", "/src/index.js"]  

