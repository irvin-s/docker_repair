FROM node:latest  
  
# Create the directory!  
RUN mkdir -p /usr/src/registry  
WORKDIR /usr/src/registry  
  
# Copy and Install  
COPY package.json /usr/src/registry/  
RUN npm install  
  
COPY ./*.js /usr/src/registry/  
COPY ./html/ /usr/src/registry/html/  
COPY ./v1/ /usr/src/registry/v1/  
COPY ./v2/ /usr/src/registry/v2/  
RUN mkdir -p /usr/src/registry/docs-build/  
RUN mkdir -p /usr/src/registry/cdn-build/  
  
# Start me!  
CMD ["node", "index.js"]  
  
EXPOSE 8000  

