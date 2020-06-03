FROM debian:wheezy  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
RUN apt-get update && \  
apt-get install -y \  
cabal-install && \  
rm -rf /var/lib/apt/lists/*  
RUN cabal update && \  
cabal install shellcheck  
  
ENV PATH /root/.cabal/bin:$PATH  
  
RUN mkdir /source  
WORKDIR /source  
CMD ["bash"]

