# This is a temporary container image to simply add the awscli package to  
# the public golang image.  
# Primarily for use with the ui-test build pipeline - we should switch to  
# using CircleCI's artifact store to remove the depenancy on S3, then we  
# can just use the public golang image.  
FROM golang:1.8.3  
RUN apt-get update && \  
apt-get install -y \  
\--no-install-recommends \  
python3-pip \  
zip \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install awscli  

