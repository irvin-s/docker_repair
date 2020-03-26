FROM alpine  
MAINTAINER Jeremy White <dudymas@gmail.com>  
  
RUN apk update && apk add jq curl  
  
COPY jq.sh jq.sh  
  
ENV METADATA_KEY=meta_key  
  
ENTRYPOINT ["/jq.sh"]  

