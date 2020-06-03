FROM datadrivenhpc/slurmbase  
#FROM datadrivenhpc/slurmbase-local  
MAINTAINER Ole Weidner <ole.weidner@ed.ac.uk>  
  
ADD scripts/start.sh /root/start.sh  
RUN chmod +x /root/start.sh  
  
ADD etc/supervisord.d/slurmctld.conf /etc/supervisor/conf.d/slurmctld.conf  
  
CMD ["/bin/bash","/root/start.sh"]  

