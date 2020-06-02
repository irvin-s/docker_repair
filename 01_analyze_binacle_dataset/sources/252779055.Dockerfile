FROM debian:wheezy  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y \  
build-essential \  
cmake \  
git \  
python \  
ssh \  
sudo \  
&& apt-get clean  
  
COPY sudoers /etc/sudoers  
RUN chmod 0660 /etc/sudoers  
  
RUN useradd -m -G sudo buzzy  
  
RUN mkdir /home/buzzy/.ssh \  
&& chown buzzy:buzzy /home/buzzy/.ssh \  
&& chmod 0700 /home/buzzy/.ssh \  
&& ssh-keyscan github.com >> /home/buzzy/.ssh/known_hosts \  
&& chown buzzy:buzzy /home/buzzy/.ssh/known_hosts \  
&& chmod 0600 /home/buzzy/.ssh/known_hosts  
  
USER buzzy  
ENV HOME /home/buzzy  
WORKDIR /home/buzzy  
CMD ["/bin/bash"]  

