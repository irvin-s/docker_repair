FROM alpine:3.4  
RUN mkdir /root/.aws  
  
RUN apk update && \  
apk add ca-certificates python py-pip jq bash && \  
pip install --upgrade awscli && \  
rm -rf /var/cache/apk/* && \  
rm -rf /tmp/*  
  
ENTRYPOINT ["/srv/dispatch"]  
  
ADD ./dispatch /srv/dispatch  
ADD ./ecs-deploy /srv/ecs-deploy  

