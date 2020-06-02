FROM azul/zulu-openjdk:8  
MAINTAINER Giovanni Silva giovanni@atende.info  
  
# Disable SSH (Not using it at the moment).  
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh  
  
# Xvfb Init script  
COPY scripts/xvfb.sh /root/xvfb  
  
# Install Tools  
RUN mkdir /root/scripts  
COPY scripts/install_tools.sh /root/install_tools.sh  
RUN chmod +x /root/install_tools.sh  
RUN /root/install_tools.sh  
  
# Setup Non Root Account  
RUN useradd -m -d /home/ciuser ciuser  
  
CMD ["/bin/bash"]  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

