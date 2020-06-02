FROM centos:centos7  
MAINTAINER XJP09_HK <jianping_xie@aliyun.com>  
  
RUN set -xe \  
&& yum install -y gcc make unzip git \  
&& yum clean all \  
&& git clone https://github.com/pacparser/pacparser.git \  
&& cd pacparser \  
&& make -C src \  
&& make -C src install \  
&& ldconfig \  
&& cd .. \  
&& rm -rf pacparser  
  
CMD ["pactester"]  

