##  
# Minimalist Docker Container for the psp sdk and toolchain  
#  
# MIT Licensed  
##  
FROM debian:7.11  
MAINTAINER Belldandu, <kami@ilp.moe>  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Dependencies  
# libtool-bin is a part of libtool as of the latest version of ubuntu  
RUN apt-get update && apt-get install -y \  
make \  
g++ \  
build-essential \  
autoconf \  
automake \  
automake1.9 \  
cmake \  
doxygen \  
bison \  
flex \  
libncurses5-dev \  
libsdl1.2-dev \  
libreadline-dev \  
libusb-dev \  
texinfo \  
libgmp3-dev \  
libmpfr-dev \  
libelf-dev \  
libmpc-dev \  
libfreetype6-dev \  
zlib1g-dev \  
libtool \  
subversion \  
git \  
tcl \  
unzip \  
wget  
  
# libtool complains if /bin/sh is dash  
RUN echo "dash dash/sh boolean false"|debconf-set-selections  
RUN dpkg-reconfigure --frontend=noninteractive dash  
  
RUN useradd -m -d /home/container container  
  
USER container  
ENV HOME /home/container  
  
WORKDIR /home/container  
  
# Only allow git to clone over https  
ENV GIT_ALLOW_PROTOCOL https  
  
# The PSPSDK is part of the toolchain  
ENV PSPDEV /home/container/pspdev  
ENV PSPSDK $PSPDEV/psp/sdk  
ENV PATH "${PATH}:$PSPDEV/bin:$PSPSDK/bin"  
COPY ./start.sh /start.sh  
  
# Moved compilation to the bash file  
CMD ["/bin/bash", "/start.sh"]  
  

