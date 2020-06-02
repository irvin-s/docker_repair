FROM ubuntu:16.04  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Update package list  
RUN apt-get -qq update  
  
RUN apt-get -qq install \  
jq \  
ssh \  
curl \  
ruby \  
ruby-dev \  
libgmp-dev \  
build-essential \  
liblzma-dev \  
zlib1g-dev \  
-y  
  
RUN gem install \  
jekyll \  
bundle  

