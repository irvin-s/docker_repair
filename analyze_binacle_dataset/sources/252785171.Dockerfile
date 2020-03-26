FROM hhvm/hhvm  
  
# Installing packages  
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*  
  
EXPOSE 9000  
ADD scripts /scripts  
  
RUN chmod +x /scripts/start.sh  
# Decouple our data from our container.  
VOLUME ["/data"]  
  
ENTRYPOINT ["/scripts/start.sh"]  

