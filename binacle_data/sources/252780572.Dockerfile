FROM babim/nginx:proxy  
  
RUN apt-get update && apt-get install -y cron  
  
RUN apt-get clean && \  
apt-get autoclean && \  
apt-get autoremove -y && \  
rm -rf /build && \  
rm -rf /tmp/* /var/tmp/* && \  
rm -rf /var/lib/apt/lists/* && \  
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup  
  
COPY runcron.sh /runcron.sh  
RUN chmod +x /runcron.sh  
  
# user  
RUN usermod -u 1024 www-data && groupmod -g 1023 www-data

