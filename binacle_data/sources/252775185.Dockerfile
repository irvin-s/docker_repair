FROM debian:latest  
MAINTAINER BearStudio <contact@bearstudio.fr>  
# Inspiration : https://docs.docker.com/engine/examples/running_ssh_service/  
ENV SSH_KEYS ""  
ENV SSH_USER "datashared"  
# Install base packages apache php imagemagick  
RUN apt-get update --quiet > /dev/null && \  
apt-get install --assume-yes --force-yes -qq \  
openssh-server sshfs && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN useradd -d /home/datashared -m -s /bin/bash datashared && \  
mkdir /home/datashared/data/ && \  
chown -R datashared:datashared /home/datashared/data/  
  
WORKDIR /home/datashared  
  
VOLUME /home/datashared/data/  
  
COPY sshd_config /etc/ssh/sshd_config  
COPY entrypoint.sh /bin/entrypoint.sh  
  
EXPOSE 22  
CMD ["/bin/entrypoint.sh"]  

