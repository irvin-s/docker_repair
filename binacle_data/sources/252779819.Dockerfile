FROM confirmed/jmeter-base  
  
EXPOSE 1099 60000  
  
ENTRYPOINT /var/lib/apache-jmeter/bin/jmeter-server \  
-Djava.rmi.server.hostname=$AWSINSTANCEIP \  
-JJVM_ID=${AWSINSTANCEIP//.}

