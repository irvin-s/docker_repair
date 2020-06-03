FROM fstab/aws-cli  
  
USER root  
  
RUN apt-get update && apt-get install -y \  
curl \  
git  
  
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -  
  
RUN apt-get install -y nodejs  
  
RUN mkdir /build && chown aws /build  
  
USER aws

