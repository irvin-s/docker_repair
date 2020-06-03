FROM abzcoding/cuckoo-base  
MAINTAINER Abouzar Parvan <abzcoding@gmail.com>  
  
WORKDIR /tmp/docker/build  
  
# Clone and Install Original Cuckoo Sandbox  
RUN git clone https://github.com/cuckoosandbox/cuckoo.git /cuckoo &&\  
chown -R cuckoo:cuckoo /cuckoo &&\  
cd /cuckoo &&\  
python utils/community.py -waf  
  
# Configure supervisord for cuckoo startup  
COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
USER cuckoo  
  
# Configure Cuckoo  
COPY conf/reporting.conf /cuckoo/conf/reporting.conf  
  
CMD ["/usr/bin/supervisord"]  

