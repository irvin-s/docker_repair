FROM buildpack-deps:xenial  
  
RUN set -ex; \  
apt-get update; \  
apt-get install -y \  
vim \  
htop \  
tree \  
tmux \  
sudo \  
iproute2 \  
net-tools \  
iputils-ping \  
openssh-server \  
bash-completion \  
; \  
useradd red -m -s /bin/bash && echo "red:red" | chpasswd ; \  
echo "red ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/red ;  
  
WORKDIR /home/red  
  
COPY ./files/* /home/red/  
  
USER red  

