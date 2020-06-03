FROM alpine  
MAINTAINER Alfredo Matas <alfredo@raisingthefloor.org>  
  
ENV GOSS_VER v0.3.5  
ENV PATH=/goss:$PATH  
  
# Install goss  
RUN apk add --no-cache --virtual=goss-dependencies curl ca-certificates && \  
mkdir /goss && \  
curl -fsSL https://goss.rocks/install | sh && \  
apk del goss-dependencies  
  
COPY healthz /usr/local/bin/  
  
VOLUME /goss  
  
CMD ["goss"]  

