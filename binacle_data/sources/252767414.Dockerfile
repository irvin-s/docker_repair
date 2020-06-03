FROM node:8  
RUN mkdir -p /opt/alexolivier.me  
COPY . /opt/alexolivier.me  
WORKDIR /opt/alexolivier.me  
RUN npm install --production  
CMD make start

