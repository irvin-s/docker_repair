FROM scratch  
LABEL maintainer='Peter Wu <piterwu@outlook.com>'  
  
ADD rootfs.tar.xz /  
  
ENV TERM=xterm \  
DEBIAN_FRONTEND=noninteractive  
  
RUN rm /bin/sh && \  
ln -s /bin/bash /bin/sh && \  
sed -i "s/mesg n/tty -s \&\& mesg n/" /root/.profile  
  
CMD ["bash"]

