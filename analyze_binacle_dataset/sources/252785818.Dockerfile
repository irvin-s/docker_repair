FROM dividab/cron-backup-base:1.1.0  
# Set default variable values  
ENV MYSQL_HOST **None**  
ENV MYSQL_PORT 3306  
ENV MYSQL_DATABASE **None**  
ENV MYSQL_USER **None**  
ENV MYSQL_PASSWORD **None**  
ENV MYSQL_EXTRA_OPTS ''  
# Install  
ADD install.sh install.sh  
RUN sh install.sh && rm install.sh  
  
# Add dump.sh script, called by our parent image  
ADD dump.sh dump.sh  

