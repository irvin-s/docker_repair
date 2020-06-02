FROM ubuntu:xenial  
MAINTAINER Chris Smith <dle@chameth.com>  
  
RUN apt-get update \  
&& apt-get install -y \  
curl \  
inotify-tools  
  
COPY dehydrated run.sh config /  
RUN chmod +x /run.sh /dehydrated  
  
VOLUME ["/letsencrypt"]  
  
ENTRYPOINT ["/bin/bash"]  
CMD ["/run.sh"]  
  

