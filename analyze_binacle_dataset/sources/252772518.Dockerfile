FROM openshift/origin  
  
RUN chmod 777 /var/lib/origin  
USER 1001  
EXPOSE 8443  
ADD ./run.sh /tmp/run.sh  
#ENTRYPOINT ["/usr/bin/openshift"]  
ENTRYPOINT ["/tmp/run.sh"]  

