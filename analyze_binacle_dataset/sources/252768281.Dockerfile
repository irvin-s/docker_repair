FROM datadog/docker-dd-agent:latest  
  
MAINTAINER Behance DevOps <devops-behance@adobe.com>  
  
# Add some checks  
COPY conf.d/mesos_slave.yaml /etc/dd-agent/conf.d/mesos_slave.yaml  
  
# Remove the docker check  
RUN rm -fv /opt/datadog-agent/agent/checks.d/docker.py  
RUN rm -fv /opt/datadog-agent/agent/checks.d/docker_daemon.py  
COPY entrypoint.sh /entrypoint.sh  
  
# Expose DogStatsD port  
EXPOSE 8125/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]  

