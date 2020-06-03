  
FROM mhart/alpine-node:6  
MAINTAINER airtonix "airtonix@gmail.com"  
ENV UNPM_FALLBACK https://registry.npmjs.com/  
  
ENV UNPM_WWW_PORT 8999  
ENV UNPM_WWW_TITLE uNpm  
ENV UNPM_WWW_STATIC /unpm-www/static  
ENV UNPM_WWW_REGISTRY https://registry:8123/  
  
WORKDIR /unpm-www  
VOLUME ${UNPM_WWW_STATIC}  
  
EXPOSE 8999  
RUN npm install -g unpm-www@1.8.0 --registry ${UNPM_FALLBACK}  
  
ENTRYPOINT unpm-www \  
\--registry ${UNPM_WWW_REGISTRY} \  
\--port ${UNPM_WWW_PORT} \  
\--static ${UNPM_WWW_STATIC} \  
\--title ${UNPM_WWW_TITLE}

