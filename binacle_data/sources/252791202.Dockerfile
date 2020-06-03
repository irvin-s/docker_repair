FROM alpine:latest  
  
RUN apk update \  
&& apk add ca-certificates wget \  
&& update-ca-certificates  
  
COPY scripts/entrypoint.sh /entrypoint  
COPY scripts/workers-cleaner.sh /concourse/workers-cleaner.sh  
  
ENV PATH="/concourse/bin:${PATH}"  
WORKDIR /concourse  
  
ENTRYPOINT ["/entrypoint"]  
  

