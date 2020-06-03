FROM alpine:latest  
LABEL maintainer "malte.brodersen@itm-consulting.de"  
  
RUN apk add --update git  
RUN wget 'http://ci.concourse.ci/api/v1/cli?arch=amd64&platform=linux' -O fly  
RUN chmod 777 fly  
RUN cp fly /sbin/fly  
  
COPY run.sh .  
RUN chmod 777 run.sh  
  
RUN mkdir git_repo  
  
ENTRYPOINT ["/bin/sh","-c","/run.sh"]  

