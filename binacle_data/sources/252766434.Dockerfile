FROM absalomedia/hhvm-dev  
  
MAINTAINER Lawrence Meckan <media@absalom.biz>  
  
RUN apt-get update \  
&& apt-get -y install wget libsodium18 libsodium-dev curl unzip git \  
&& apt-get -y upgrade \  
&& apt-get -y autoremove \  
&& apt-get -y clean \  
&& rm -rf /tmp/* /var/tmp/*  
  
RUN export CXX="g++-4.9"  
  
WORKDIR /usr/src  
  
RUN git clone https://github.com/absalomedia/sodium.git && \  
cd sodium && \  
git submodule update --init --recursive && \  
hphpize && \  
cmake . && \  
make && \  
make install  

