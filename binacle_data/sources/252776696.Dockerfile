FROM datadog/docker-dd-agent  
ADD run.sh /run.sh  
RUN chmod 755 /run.sh  
CMD /run.sh  

