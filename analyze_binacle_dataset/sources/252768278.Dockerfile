FROM datadog/docker-dd-agent:11.3.585  
MAINTAINER Ethos DevOPS <Ethos_Dev@adobe.com>  
  
#install dnsutils  
RUN apt-get update --fix-missing \  
&& apt-get install -y dnsutils \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Add the entrypoint  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
# Extra conf.d and checks.d  
CMD mkdir -p /conf.d  
CMD mkdir -p /checks.d  
VOLUME ["/conf.d"]  
VOLUME ["/checks.d"]  
  
# Add ethos checks  
ADD checks.d/ /checks.d/  
ADD conf.d/ /conf.d/  
  
# Expose DogStatsD port  
EXPOSE 8125/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["supervisord", "-n", "-c", "/etc/dd-agent/supervisor.conf"]  

