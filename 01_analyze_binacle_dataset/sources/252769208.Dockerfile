FROM node:6-alpine  
  
LABEL maintainer="Angristan https://github.com/Angristan/dockerfiles"  
LABEL source="https://github.com/Angristan/dockerfiles/tree/master/hastebin"  
  
ENV UID=4242 GID=4242  
RUN apk -U upgrade \  
&& apk --no-cache add git su-exec \  
&& git clone https://github.com/seejohnrun/haste-server.git /app \  
&& cd /app \  
&& npm install \  
&& npm cache clean  
  
COPY rootfs /  
  
RUN chmod +x /usr/local/bin/run.sh  
  
VOLUME /app/data  
  
EXPOSE 7777  
CMD ["run.sh"]

