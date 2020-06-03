FROM alpine:latest  
RUN apk add --update openssh ruby bash vim && rm -rf /var/cache/apk/*  
RUN mkdir -p /root/.ssh  
ADD run.rb /run.rb  
  
CMD ruby run.rb  

