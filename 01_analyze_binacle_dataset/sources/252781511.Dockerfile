FROM ubuntu:trusty  
  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:git-core/ppa && \  
apt-get update && \  
apt-get install -y \  
curl \  
wget \  
git-core \  
curl \  
tmux  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
WORKDIR /home/docker  
  
RUN curl -sSL https://get.rvm.io | bash  
RUN /home/docker/.rvm/bin/rvm install 2.1.0  
RUN source "$HOME/.rvm/scripts/rvm" \  
rvm alias create default ruby-2.1.0  
  
CMD ["/bin/bash"]  

