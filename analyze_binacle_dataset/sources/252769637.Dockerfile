FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y curl  
RUN apt-get install -y nmap  
RUN apt-get install -y socat  
RUN apt-get install -y openssh-client  
RUN apt-get install -y openssl  
RUN apt-get install -y iotop  
RUN apt-get install -y strace  
RUN apt-get install -y tcpdump  
RUN apt-get install -y lsof  
RUN apt-get install -y inotify-tools  
RUN apt-get install -y sysstat  
RUN apt-get install -y build-essential  
RUN echo "source /root/bash_extra" >> /root/.bashrc  
ADD bash_extra /root/bash_extra  
CMD ["/bin/bash"]

