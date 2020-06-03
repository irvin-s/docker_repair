FROM node:6-alpine  
  
ADD src /tool  
  
RUN cd /tool && chmod +x docker-entrypoint.sh && npm install  
  
ENV RESX2CS_NAMESPACE=NAMESPACE_NAME  
ENV RESX2CS_CLASS_NAME=CLASS_NAME  
ENV RESX2CS_RESOURCE_NAME=RESOURCE_NAME  
  
WORKDIR /tool  
VOLUME /data  
  
ENTRYPOINT ["/tool/docker-entrypoint.sh"]  

