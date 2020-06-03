FROM nvidia/cuda:7.5-cudnn4-runtime  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV LANG C.UTF-8  
ENV PATH /opt/conda/bin:$PATH  
RUN locale-gen "en_US.UTF-8" && dpkg-reconfigure locales  
  
ENV HOME /root  
RUN apt-get update && \  
apt-get install -y --force-yes --no-install-recommends \  
supervisor xinetd x11vnc xvfb tinywm \  
openbox xdotool wmctrl x11-utils xterm && \  
apt-get autoclean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/*  

