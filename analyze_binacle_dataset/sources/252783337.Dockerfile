FROM node:8.2-alpine  
  
WORKDIR /esspunkt60  
  
COPY app /esspunkt60/app  
COPY public /esspunkt60/public  
COPY package.json /esspunkt60/package.json  
COPY index.js /esspunkt60/index.js  
  
RUN npm install && \  
mkdir -p /esspunkt60/public/upload/doc && \  
mkdir -p /esspunkt60/public/upload/images  
  
CMD ["/usr/local/bin/node","/esspunkt60/index.js"]  

