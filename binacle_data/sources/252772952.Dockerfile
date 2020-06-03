FROM debian  
  
RUN apt-get update \  
&& apt-get install -y --force-yes --no-install-recommends \  
motion sudo procps \  
&& apt-get autoclean \  
&& apt-get autoremove \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD startup.sh /  
  
RUN chmod +x /startup.sh &&\  
mkdir -p /data/Motion/movies &&\  
mkdir -p /data/Motion/pictures &&\  
mkdir /conf &&\  
mkdir /bootstrap &&\  
touch /data/Motion/motion.pid &&\  
useradd -b /home/vc -d /home/vc -u 1000 -s /bin/bash -m vc &&\  
echo "vc:passw0rd" | chpasswd &&\  
chown -R vc.vc /data &&\  
chown -R vc.vc /conf &&\  
chown -R vc.vc /bootstrap &&\  
echo "vc ALL=(ALL) ALL" >> /etc/sudoers  
  
USER vc  
  
ADD motion.conf /bootstrap/  
  
EXPOSE 8081  
ENTRYPOINT ["/startup.sh"]  

