FROM datadrivenhpc/slurmbase  
  
MAINTAINER Ole Weidner <ole.weidner@ed.ac.uk>  
  
ADD scripts/start.sh /root/start.sh  
RUN chmod +x /root/start.sh  
  
ADD etc/supervisord.d/slurmd.conf /etc/supervisor/conf.d/slurmd.conf  
  
CMD ["/bin/bash","/root/start.sh"]  

