FROM debian:unstable-slim  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends iptables sshguard systemd \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD start-sshguard.sh /  
  
ENTRYPOINT ["/start-sshguard.sh"]  

