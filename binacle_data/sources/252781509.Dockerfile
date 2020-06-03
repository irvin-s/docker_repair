FROM ubuntu:precise  
  
RUN apt-get update && \  
apt-get install -y \  
wget \  
curl \  
man-db \  
software-properties-common \  
python-software-properties && \  
add-apt-repository ppa:git-core/ppa && \  
add-apt-repository ppa:brightbox/ruby-ng && \  
apt-get update && \  
apt-get install -y \  
sudo \  
git-core \  
build-essential \  
cmake \  
ntp \  
ruby2.2 \  
libboost1.48-all-dev \  
libpython2.7 \  
libpython3.2 \  
libssl-dev \  
sqlite3 \  
libsqlite3-dev \  
libxml2-dev \  
redis-server \  
libhiredis-dev \  
debhelper \  
dkms \  
vim  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
  
CMD ["/bin/bash"]  

