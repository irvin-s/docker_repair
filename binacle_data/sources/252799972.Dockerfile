FROM alpine:3.3  
RUN apk --update add \  
bash \  
curl  
ADD slackpost.sh .  
ENTRYPOINT ["/bin/bash", "slackpost.sh"]  

