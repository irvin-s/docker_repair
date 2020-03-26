FROM busybox:latest  
MAINTAINER David Lee Crites <lee@critesclan.com>  
  
# Make the directories and specify the VOLUMEs to expose.  
RUN mkdir -pm 0777 /opt/splunk && \  
mkdir -pm 0777 /opt/splunk/temp && \  
mkdir -pm 0777 /opt/splunk/etc && \  
mkdir -pm 0777 /opt/splunk/var  
VOLUME [ "/opt/splunk/temp", "/opt/splunk/etc", "/opt/splunk/var" ]  
  
# Build the entrypoint script, and specify it.  
RUN echo '#!/bin/sh' 1>/entrypoint.sh && \  
echo 'tail -f /dev/null' 1>>/entrypoint.sh && \  
chmod 755 /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["busybox"]  

