FROM confirmed/jmeter-base  
  
# Expose access to logs & data files  
VOLUME [ "/logs" ]  
VOLUME [ "/input-data" ]  
  
# Expose jmeter-server's port -> defined in jmeter.properties  
EXPOSE 1099 60000  
# Run jmeter-server  
#ENTRYPOINT [ "/var/lib/apache-jmeter/bin/jmeter-server" ]  

