FROM doomhammer/ptxdist-base  
MAINTAINER Piotr Gaczkowski <DoomHammerNG@gmail.com>  
  
RUN cd /usr/src/ptxdist && \  
git checkout ptxdist-2013.01.0 && \  
./autogen.sh && \  
./configure && \  
make && \  
make install && \  
rm -rf /usr/src  
  
ENTRYPOINT [ "/usr/local/bin/ptxdist" ]  

