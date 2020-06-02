FROM dimo414/base  
  
RUN apt-get update && apt-get install -y \  
binutils \  
g++ \  
gcc \  
libncurses5-dev \  
libncursesw5-dev \  
make \  
perl \  
qemu  
  
COPY install-bochs.sh install-bochs.sh  
RUN ./install-bochs.sh  
  
LABEL \  
version="0.1" \  
description="Image for CS140"

