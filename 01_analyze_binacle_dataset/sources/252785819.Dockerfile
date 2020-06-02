FROM dividab/cron-backup-base:1.0.0  
# Set default variable values  
ENV POSTGRES_HOST **None**  
ENV POSTGRES_PORT 5432  
ENV POSTGRES_DATABASE **None**  
ENV POSTGRES_USER **None**  
ENV POSTGRES_PASSWORD **None**  
ENV POSTGRES_EXTRA_OPTS '--format=c'  
# Install  
ADD install.sh install.sh  
RUN sh install.sh && rm install.sh  
  
# Add dump.sh script, called by our parent image  
ADD dump.sh dump.sh  

