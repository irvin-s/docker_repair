FROM ubuntu  
MAINTAINER Alex Forsythe  
  
# Install Applications  
RUN apt-get update && apt-get install -y \  
build-essential \  
cmake \  
autoconf \  
libtool \  
git \  
libtiff5-dev \  
pkg-config \  
zlib1g-dev \  
libilmbase-dev \  
libopenexr-dev  
  
# Clone Git Repositories  
RUN mkdir src && cd /src \  
&& git clone https://github.com/ampas/aces_container.git \  
&& git clone https://github.com/ampas/ctl.git \  
&& git clone https://github.com/ampas/aces-dev.git  
  
# Set Environment Variables  
ENV LD_LIBRARY_PATH /usr/local/lib  
ENV CTL_MODULE_PATH /src/aces-dev/transforms/ctl/lib  
  
# ACES Container  
RUN cd /src/aces_container \  
&& mkdir build \  
&& cd build \  
&& cmake .. \  
&& make \  
&& make install  
  
# CTL  
RUN cd /src/ctl \  
&& mkdir build \  
&& cd build \  
&& cmake -Wno-dev .. \  
&& make \  
&& make install  
  
# Create a soft link to make ctlrender commands shorter  
RUN ln -s /src/aces-dev/transforms/ctl/ /ctl  
  
CMD ["/bin/bash"]

