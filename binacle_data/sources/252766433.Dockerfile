FROM absalomedia/hhvm-dev  
  
MAINTAINER Lawrence Meckan <media@absalom.biz>  
  
RUN apt-get update \  
&& apt-get -y install wget curl unzip git \  
&& apt-get -y upgrade \  
&& apt-get -y autoremove \  
&& apt-get -y clean \  
&& rm -rf /tmp/* /var/tmp/*  
  
RUN export CXX="g++-4.9"  
  
WORKDIR /usr/src  
  
RUN git clone https://github.com/absalomedia/sasshhvm.git && \  
cd sasshhvm && \  
git submodule update --init --recursive && \  
hphpize && \  
cmake . && \  
make && \  
make install  

