FROM ubuntu:trusty  
  
RUN useradd -u 1000 -d /work user  
  
RUN apt-get update && \  
apt-get install -y curl xorg libxss1 && \  
apt-get clean  
  
RUN curl http://ds9.si.edu/download/linux64/ds9.linux64.7.3.2.tar.gz \  
| tar xz -C /usr/local/bin  
  
#VOLUME /tmp/.X11-unix  
ENV DISPLAY unix:0  
USER user  
WORKDIR /work  
VOLUME /work  
  
ENTRYPOINT ["/usr/local/bin/ds9"]  
  

