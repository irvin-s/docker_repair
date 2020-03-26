FROM defensative/baseimage:production  
  
MAINTAINER DEFENSATIVE Docker Mantainers "docker-maint@defensative.com"  
  
ADD smoke_test.py /usr/sbin/smoke_test.py  
ADD run.sh /usr/sbin/run.sh  
  
RUN apt-get update && \  
apt-get install -y socat && \  
apt-get purge -y man && \  
apt-get clean autoclean && \  
apt-get autoremove -y && \  
(dpkg -l | grep ^rc | awk '{print $2}' | xargs dpkg -P || true) && \  
rm -Rf /tmp/* && \  
rm -Rf /var/lib/apt/lists/*.gz && \  
rm -Rf /var/lib/cache/* && \  
rm -Rf /var/lib/log/* && \  
rm -Rf /var/log/* && \  
rm -Rf /var/cache/*  
  
ENTRYPOINT ["/usr/sbin/run.sh"]  

