FROM debian  
MAINTAINER Kadira Inc.  
  
RUN apt-get update && \  
apt-get install -y \  
zlib1g-dev  
  
COPY lib/install-nginx.sh /tmp/install-nginx.sh  
RUN bash /tmp/install-nginx.sh  
RUN rm /tmp/install-nginx.sh  
  
COPY lib /tmp/lib  
RUN bash /tmp/lib/copy-files.sh  
  
RUN chmod +x /verify.sh /start.sh

