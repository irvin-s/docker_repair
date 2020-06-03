############################################################  
# Dockerfile to build borgbackup server images  
# Based on Debian  
############################################################  
FROM alpine:latest  
  
# Volume for SSH-Keys  
VOLUME /sshkeys  
  
# Volume for borg repositories  
VOLUME /backup  
  
RUN apk add --no-cache \  
openssh-server openssh-server-pam ca-certificates \  
python3 lz4-libs libattr libacl libressl zstd && \  
apk add --no-cache --virtual .build-deps \  
gcc g++ libc-dev make pcre-dev zlib-dev \  
python3-dev lz4-dev acl-dev attr-dev zstd-dev \  
libressl-dev cython cython-dev linux-headers && \  
pip3 install --upgrade pip && \  
pip3 install borgbackup==1.1.5 && \  
apk del .build-deps  
  
RUN addgroup borg && \  
adduser -D -s /bin/sh -G borg -h /home/borg borg && \  
mkdir /home/borg/.ssh && \  
chmod 700 /home/borg/.ssh && \  
chown borg: /home/borg/.ssh && \  
mkdir /run/sshd  
RUN rm -f /etc/ssh/ssh_host*key* && \  
rm -rf /var/tmp/* /tmp/*  
  
COPY ./data/run.sh /run.sh  
COPY ./data/sshd_config /etc/ssh/sshd_config  
  
ENTRYPOINT /bin/sh /run.sh  
  
# Default SSH-Port for clients  
EXPOSE 22  

