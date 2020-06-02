FROM docker:1.12  
MAINTAINER Dewey Sasser <dewey@sasser.com>  
  
RUN apk add --no-cache inotify-tools  
  
ADD run.sh login.sh /root/  
ENTRYPOINT ["/root/run.sh"]  
CMD ["/root/login.sh"]

