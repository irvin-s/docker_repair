FROM ubuntu:precise  
  
RUN apt-get update && \  
apt-get install -y sudo  
  
RUN useradd -m -G sudo docker  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
  
CMD ["/bin/bash"]  

