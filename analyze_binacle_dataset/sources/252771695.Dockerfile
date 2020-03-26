FROM debian:jessie  
  
LABEL maintainer="Fabrice Baumann"  
  
# Get repository and install wget and vim  
RUN apt-get update && apt-get install --no-install-recommends -y \  
ca-certificates \  
curl \  
libcurl4-openssl-dev \  
wget \  
git \  
zip \  
g++ \  
make  
  
WORKDIR /opt/zstandard/  
  
RUN git clone https://github.com/facebook/zstd.git . && \  
make && \  
ln -s /opt/zstandard/zstd /usr/local/bin/zstd  
  
COPY comp.sh /usr/local/bin/comp  
  
WORKDIR /var/www  
  
CMD ["zstd", "tar", "comp"]  

