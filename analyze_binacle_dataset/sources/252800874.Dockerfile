FROM nginx:alpine  
WORKDIR /app  
COPY assets /app/assets  
COPY bin /app  
COPY index.js /app  
COPY index.css /app  
COPY index.html /app/IntelliJIDEALicenseServer.html  
COPY default.conf /etc/nginx/conf.d/default.conf  
COPY run.sh /app  
ENTRYPOINT /app/run.sh  

