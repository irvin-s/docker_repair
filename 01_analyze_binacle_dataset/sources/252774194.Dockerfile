FROM alpine:latest  
  
ENV RANCHER_API_KEY \  
RANCHER_ENV \  
RANCHER_HOST \  
RANCHER_TAGS \  
RANCHER_HTTP_SCHEME  
  
RUN apk --no-cache add curl jq  
  
COPY ./scripts/run.sh /tmp/run.sh  
  
RUN chmod 755 /tmp/run.sh  
  
ENTRYPOINT /tmp/run.sh  

