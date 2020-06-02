FROM alpine:3.7  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
ENV VARNISH_CACHE_SIZE=128m \  
BACKEND_PORT=80  
WORKDIR /opt  
  
COPY varnish.vcl start ./  
  
RUN apk add --no-cache varnish && \  
chmod +x start  
  
CMD ./start  
  
EXPOSE 80  

