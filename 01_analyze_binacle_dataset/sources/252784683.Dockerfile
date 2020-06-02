FROM debian:jessie  
  
MAINTAINER blacktop, https://github.com/blacktop  
  
# COPY install scripts to tmp folder  
COPY install /tmp/install  
RUN chmod -R 755 /tmp/install  
  
# Install ChopShop Required Dependencies  
RUN buildDeps='apt-utils \  
autoconf \  
automake \  
build-essential \  
git-core \  
libemu-dev \  
libmagic-dev \  
libpcre3-dev \  
libssl-dev \  
python-dev \  
python-setuptools' \  
&& set -x \  
&& echo "[INFO] Installing Dependancies..." \  
&& apt-get -q update \  
&& apt-get install -y $buildDeps \  
ca-certificates \  
libpcap-dev \  
libpcre3 \  
libtool \  
python \  
python-yara \  
swig \  
yara --no-install-recommends \  
&& easy_install pymongo \  
M2Crypto \  
pycrypto \  
dnslib \  
&& echo "[INFO] Installing ChopShop..." \  
&& cd /tmp \  
&& install/pynids.sh \  
&& install/htpy.sh \  
&& install/yaraprocessor.sh \  
&& install/pylibemu.sh \  
&& install/chopshop.sh \  
&& echo "[INFO] Remove Build Dependancies..." \  
&& apt-get autoremove --purge -y $buildDeps \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
VOLUME ["/pcap"]  
WORKDIR /pcap  
  
ENTRYPOINT ["/usr/local/bin/chopshop"]  
  
CMD ["-h"]  

