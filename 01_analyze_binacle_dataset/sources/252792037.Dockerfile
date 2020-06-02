FROM debian:stretch  
MAINTAINER Chris Hardekopf <chrish@basis.com>  
  
# Install pip  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y python-pip && \  
rm -rf /var/lib/apt/lists/*  
  
# Install s3cmd using pip in order to get the latest version  
RUN pip install s3cmd  
  
# Set the entrypoint  
ENTRYPOINT [ "/usr/local/bin/s3cmd" ]  

