FROM ubuntu  
  
RUN apt-get update && \  
apt-get install -y \  
subversion \  
g++ \  
zlib1g-dev \  
build-essential \  
git \  
python \  
rsync \  
man-db \  
libncurses5-dev \  
gawk \  
gettext \  
unzip \  
file \  
libssl-dev \  
wget && \  
apt-get clean  
  
RUN git clone https://git.lede-project.org/source.git lede  
  
WORKDIR lede  
  
RUN ./scripts/feeds update -a && \  
./scripts/feeds install -a && \  
make defconfig  

