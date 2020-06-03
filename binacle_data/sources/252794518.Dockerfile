FROM openjdk:9-jre  
  
ENV TIKA_VERSION=1.17  
ENV TIKA_PORT=9998  
  
ADD https://www.apache.org/dist/tika/tika-server-${TIKA_VERSION}.jar \  
/var/lib/tika/  
  
EXPOSE ${TIKA_PORT}  
  
ENTRYPOINT java -jar /var/lib/tika/tika-server-${TIKA_VERSION}.jar \  
\--host 0.0.0.0 \  
\--port ${TIKA_PORT}  

