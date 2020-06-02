FROM ubuntu:14.04  
  
RUN apt-get update -q && apt-get install -y \  
libflac-dev \  
libmagickwand-dev \  
libcurl4-gnutls-dev \  
libdiscid0-dev \  
libcdparanoia-dev \  
make \  
wget \  
&& rm -rf /var/lib/apt/lists/* \  
&& mkdir /ripright \  
&& cd /ripright \  
&& wget http://www.mcternan.me.uk/ripright/software/ripright-0.11.tar.gz \  
&& tar -zxf ripright-0.11.tar.gz \  
&& cd /ripright/ripright-0.11 \  
&& ./configure \  
&& make \  
&& make check \  
&& make install \  
&& apt-get install -qy \  
libcdparanoia0 \  
libcurl3-gnutls \  
libdiscid0 \  
libflac8 \  
libmagickwand5 \  
&& apt-get remove -qy \  
libflac-dev \  
libmagickwand-dev \  
libcurl4-gnutls-dev \  
libdiscid0-dev \  
libcdparanoia-dev \  
make \  
wget \  
&& apt-get autoremove -qy  

