FROM fedora:latest  
  
RUN dnf -y update && \  
dnf -y install sudo git  
  
RUN useradd -m -G wheel docker  
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
USER docker  
WORKDIR /home/docker  
  
CMD ["/bin/bash"]  

