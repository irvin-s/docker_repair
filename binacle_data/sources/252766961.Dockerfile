FROM alpine:3.7  
ARG FLEXGET_VERSION=2.11.23  
RUN apk add --no-cache ca-certificates python2 py-pip && \  
pip install flexget==$FLEXGET_VERSION transmissionrpc && \  
rm -rf ~/.cache/pip && rm -rf /var/cache/apk/*  
  
RUN addgroup -S flexget && adduser -SD -G flexget flexget  
  
USER flexget  
RUN mkdir /home/flexget/.flexget  
  
EXPOSE 3539  
VOLUME /home/flexget/.flexget  
  
CMD ["flexget", "--loglevel", "info", "daemon", "start"]  

