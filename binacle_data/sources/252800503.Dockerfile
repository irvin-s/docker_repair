FROM debian:stretch-20170907  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y apt-utils \  
forensics-all \  
foremost \  
binwalk \  
exiftool \  
outguess \  
pngtools \  
pngcheck \  
stegosuite \  
git \  
hexedit \  
python3-pip \  
python-pip \  
autotools-dev \  
automake \  
libevent-dev \  
bsdmainutils \  
ffmpeg \  
crunch \  
cewl \  
sonic-visualiser \  
atomicparsley  
  
RUN pip3 install python-magic  
  
RUN pip install tqdm  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY install /tmp/install  
RUN find /tmp/install -name '*.sh' -exec chmod a+x {} + && \  
find /tmp/install -type f -executable -exec {} \; && \  
rm -rf /tmp/install  
  
# Use this section to try new installation scripts.  
# All previous steps will be cached  
#  
# COPY install_dev /tmp/install  
# RUN find /tmp/install -name '*.sh' -exec chmod a+x {} + && \  
# for f in $(ls /tmp/install/* | sort );do /bin/sh $f;done && \  
# rm -rf /tmp/install  
COPY scripts /opt/scripts  
RUN find /opt/scripts -name '*.sh' -exec chmod a+x {} + && \  
find /opt/scripts -name '*.py' -exec chmod a+x {} +  
ENV PATH="/opt/scripts:${PATH}"  
WORKDIR /data  

