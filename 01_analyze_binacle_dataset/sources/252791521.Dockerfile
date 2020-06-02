FROM ubuntu:16.04  
LABEL maintainer="Davide Fiorentino lo Regio"  
LABEL maintainer-twitter="@daftano"  
  
RUN apt-get update \  
&& apt-get install -qqy --no-install-recommends locales \  
&& locale-gen en_US.UTF-8 \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update \  
&& apt-get install -qqy --no-install-recommends apt-utils \  
&& apt-get install -qqy --no-install-recommends \  
curl \  
dnsutils \  
iputils-ping \  
lynx \  
software-properties-common \  
telnet \  
traceroute \  
unzip \  
uuid-runtime \  
wget \  
&& rm -rf /var/lib/apt/lists/*  

