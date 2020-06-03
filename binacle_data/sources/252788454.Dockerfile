##########################################################################  
# Image: crownpeak/alpine:3.5  
# Maintained by: CrownPeak Advanced Solutions Group <asg@crownpeak.com>  
##########################################################################  
FROM alpine:3.5  
MAINTAINER Crownpeak Advanced Solutions Group <asg@crownpeak.com>  
  
ENV REFRESHED_AT 2017-04-26  
  
# Tweak root profile  
ADD bashrc /root/.bashrc  
RUN apk add --update bash curl && rm -rf /var/cache/apk/*  
RUN mkdir -p /scratch /opt/container/  
ADD startcontainer.sh /opt/container/  
RUN chmod u+x /opt/container/startcontainer.sh  
  
ENTRYPOINT [ "/bin/bash", "/opt/container/startcontainer.sh" ]

