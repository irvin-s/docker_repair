FROM ubuntu:18.04  
MAINTAINER Jan Kunzmann <jan-docker@phobia.de>  
  
RUN apt-get update && apt-get install -y \  
systemd \  
sshguard \  
iptables \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY script/sshguard-stream-journal.sh /app/sshguard-stream-journal.sh  
  
ENTRYPOINT ["/app/sshguard-stream-journal.sh"]  

