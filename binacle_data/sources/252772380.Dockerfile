FROM fedora:26  
MAINTAINER pioh "thepioh@zoho.com"  
RUN dnf update --setopt=tsflags=nodocs -y  
RUN dnf install --setopt=tsflags=nodocs -y wget  
RUN dnf install --setopt=tsflags=nodocs -y tar  
RUN dnf install --setopt=tsflags=nodocs -y perl perl-core  
RUN dnf install --setopt=tsflags=nodocs -y gcc  
RUN dnf install --setopt=tsflags=nodocs -y gcc-c++  
RUN dnf install --setopt=tsflags=nodocs -y make  
RUN dnf install --setopt=tsflags=nodocs -y pkgconfig  
RUN dnf install --setopt=tsflags=nodocs -y git  
RUN dnf install --setopt=tsflags=nodocs -y unzip  
  
RUN cd ~ \  
&& wget https://www.openssl.org/source/openssl-1.1.0g.tar.gz \  
&& tar xf openssl-1.1.0g.tar.gz \  
&& cd openssl-1.1.0g \  
&& mkdir -p /opt \  
&& ./config --prefix=/opt/openssl --openssldir=/usr/ssl \  
&& make \  
&& make install \  
&& rm -rf /opt/openssl/share \  
&& cp -r /opt/openssl/* /usr/ \  
&& ldconfig \  
&& openssl version \  
&& cd ~ \  
&& rm -rf openssl* /opt/openssl  
  
RUN dnf install --setopt=tsflags=nodocs -y findutils  
  
CMD ["/bin/bash"]  

