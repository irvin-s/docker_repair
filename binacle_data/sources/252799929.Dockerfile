FROM debian:latest  
#MAINTAINER digmore  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
ca-certificates \  
g++ \  
git \  
libboost-dev \  
libboost-test-dev \  
libboost-tools-dev \  
libgssglue-dev \  
libkrb5-dev \  
libpng12-dev \  
libsnappy-dev \  
libssl-dev \  
locales \  
python-dev \  
python-pkg-resources \  
python-pip \  
&& rm -fr /var/lib/apt/lists/* \  
&& rm -fr /tmp/* \  
&& rm -fr /var/tmp/*  
  
RUN pip install honcho  
COPY Procfile /Procfile  
  
RUN mkdir /opt/redemption  
WORKDIR /opt/redemption  
  
# Using single RUN instruction to avoid build files ending up in image  
RUN git clone https://github.com/wallix/redemption.git /opt/redemption && \  
git submodule init && git submodule update && \  
bjam exe && \  
bjam install && \  
mv /opt/redemption/tools/passthrough /opt/passthrough && \  
rm -rf /opt/redemption  
  
EXPOSE 3389/tcp  
CMD ["/usr/local/bin/honcho", "-d", "/", "-f", "Procfile", "start"]  
  

