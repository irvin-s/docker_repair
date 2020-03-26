FROM atende/baseimage-jdk  
  
MAINTAINER Giovanni Silva giovanni@atende.info  
  
ENV SOFTWARE_NAME=stash  
  
ENV SOFTWARE_VERSION=3.9.2  
ENV SOFTWARE_PORT=7990  
ENV STASH_HOME /opt/stash-home  
  
ENV SCALA_HOME /usr/local/scala  
  
# Disable SSH (Not using it at the moment).  
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh  
  
COPY install.sh /root/install.sh  
  
RUN chmod +x /root/install.sh  
  
# Install  
RUN apt-get update -q && apt-get install -y git \  
perl  
  
RUN mkdir /root/scripts  
COPY scripts/install_impl.sh /root/scripts/install_impl.sh  
COPY scripts/configuration.scala /root/scripts/configuration.scala  
COPY install_tools.sh /root/install_tools.sh  
RUN chmod +x /root/scripts/install_impl.sh;chmod +x /root/install_tools.sh  
RUN /root/install_tools.sh  
RUN /root/install.sh  
  
# Run  
COPY run.sh /etc/my_init.d/run.sh  
COPY scripts/run_impl.sh /root/scripts/run_impl.sh  
RUN chmod +x /etc/my_init.d/run.sh  
  
EXPOSE 7990  
# Default SSH Port  
EXPOSE 7999  
CMD ["/sbin/my_init"]  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

