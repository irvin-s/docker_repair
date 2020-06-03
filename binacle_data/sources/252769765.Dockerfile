FROM debian:sid  
MAINTAINER Arnau Siches <asiches@gmail.com>  
  
RUN apt-get update -qq \  
&& apt-get install -qqy \  
cmake \  
curl \  
file \  
git \  
libgit2-dev \  
libssl-dev  
  
RUN curl -L -o rustup.sh https://static.rust-lang.org/rustup.sh \  
&& chmod +x rustup.sh \  
&& ./rustup.sh --yes --disable-sudo  
  
# cleanup package manager  
RUN apt-get remove --purge -y curl \  
&& apt-get autoclean \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
VOLUME ["/source"]  
WORKDIR /source  
CMD ["bash"]  

