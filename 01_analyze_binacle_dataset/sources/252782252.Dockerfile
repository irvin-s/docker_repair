FROM java:8  
ADD launchMetronomeJobs.sh /usr/local/bin/  
ADD orchestrator-server.jar /opt/  
RUN ["chmod", "+x", "/usr/local/bin/launchMetronomeJobs.sh"]  
ENTRYPOINT [ "/usr/local/bin/launchMetronomeJobs.sh"]

