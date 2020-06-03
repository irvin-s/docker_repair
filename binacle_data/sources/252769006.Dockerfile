FROM alpine:latest  
  
MAINTAINER Jaehoon Choi <plaintext@andromedarabbit.net>  
  
RUN apk add --update curl && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /  
  
COPY slack.sh /usr/local/bin/  
  
CMD ["/usr/local/bin/slack.sh"]  

