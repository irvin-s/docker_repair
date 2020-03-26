FROM alpine:3.6  
MAINTAINER Code Climate <hello@codeclimate.com>  
  
RUN apk update \  
&& apk add jq curl \  
&& rm -rf /var/cache/apk/*  
  
WORKDIR /app  
  
COPY run.sh /app/run.sh  
  
ENTRYPOINT ["/app/run.sh"]  

