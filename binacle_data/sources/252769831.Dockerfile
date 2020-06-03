FROM debian:jessie  
  
RUN apt-get update \  
&& apt-get -qy --no-install-recommends install \  
unzip \  
cpio \  
curl \  
wget \  
&& apt-get -q -y clean \  
&& rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \  
&& rm -rf /usr/share/man/?? /usr/share/man/??_*  
  
RUN mkdir /src  
COPY unitycacheserver.sh /src/  
RUN chmod a+x /src/unitycacheserver.sh  
  
WORKDIR /src/  
ENTRYPOINT ["/src/unitycacheserver.sh"]  

