# Set the base image  
FROM ubuntu:16.04  
# Dockerfile author/maintainer  
MAINTAINER Chris Mattingly <camattin@gmail.com>  
  
RUN apt-get update \  
&& apt-get -qq --no-install-recommends install \  
ca-certificates \  
wget \  
libxcb1 \  
libpcre16-3 \  
&& rm -r /var/lib/apt/lists/*  
  
RUN wget -q --content-disposition https://minergate.com/download/deb-cli \  
&& dpkg -i *.deb \  
&& rm *.deb  
  
ENTRYPOINT ["minergate-cli"]  
CMD ["--user", "camattin@gmail.com", "--xmr"]  

