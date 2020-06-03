ARG BASE=node:8-slim  
FROM $BASE  
  
ARG arch=arm  
ENV ARCH=$arch  
  
COPY qemu/qemu-$ARCH-static* /usr/bin/  
  
LABEL MAINTAINER="github@angelnu.com"  
LABEL SRC="https://github.com/angelnu/kubernetes-glusterfs-server"  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update && \  
#apt-get install software-properties-common -y && \  
#add-apt-repository ppa:gluster/glusterfs-3.10 -y && \  
#apt-get update && \  
apt-get install -y glusterfs-server \  
iproute2 \  
supervisor \  
openssh-server \  
dnsutils sshpass && \  
apt-get -y clean all  
  
ENV ROOT_PASSWORD="**ChangeMe**" \  
SSH_PORT=2222 \  
SSH_USER=root \  
GLUSTER_VOLUMES=vol \  
GLUSTER_VOL_OPTS="" \  
GLUSTER_ALL_VOLS_OPTS="" \  
GLUSTER_BRICK_PATH=/gluster_volume \  
SERVICE_NAME=gluster \  
DEBUG=0  
  
VOLUME ["${GLUSTER_BRICK_PATH}"]  
  
RUN mkdir -p /var/run/sshd /root/.ssh /var/log/supervisor /usr/local/bin  
  
ADD ./bin /usr/local/bin  
ADD ./etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
ENTRYPOINT ["/usr/local/bin/run.sh"]  

