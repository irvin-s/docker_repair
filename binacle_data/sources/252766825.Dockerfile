FROM ubuntu:xenial  
  
MAINTAINER Alan Quach <integsrtite@gmail.com>  
  
# CORE  
RUN apt-get update && apt-get install -y \  
apt-transport-https \  
software-properties-common \  
&& apt-add-repository -y ppa:git-core/ppa  
RUN apt-get update && apt-get install -y \  
tzdata \  
locales \  
openssh-server \  
ca-certificates \  
curl \  
rsync \  
zip unzip tar \  
dnsutils \  
man \  
build-essential \  
cmake python-dev \  
tmux \  
git \  
vim \  
silversearcher-ag \  
mosh \  
python-pip \  
&& mkdir /var/run/sshd  
ADD bootstrap.sh /tmp/bootstrap.sh  
RUN locale-gen en_US.UTF-8  
  
CMD ["/usr/sbin/sshd", "-D"]  

