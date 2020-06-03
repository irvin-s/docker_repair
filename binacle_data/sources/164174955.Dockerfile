# sshd, matlab, dcmdump (via dcmtk)

FROM ubuntu:12.04

ADD matlab.txt /mcr-install/matlab.txt
ADD id_rsa.pub /root/.ssh/authorized_keys
ADD assets /root/assets

RUN \
   apt-get update && \
   apt-get install -y curl wget xorg unzip openssh-server dcmtk && \
   mkdir /var/run/sshd

RUN \
   cd /mcr-install && \
   wget -nv http://www.mathworks.de/supportfiles/downloads/R2013b/deployment_files/R2013b/installers/glnxa64/MCR_R2013b_glnxa64_installer.zip && \
   unzip MCR_R2013b_glnxa64_installer.zip && \
   mkdir /opt/mcr && \
   ./install -inputFile matlab.txt && \
   cd / && \
   rm -rf mcr-install

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
