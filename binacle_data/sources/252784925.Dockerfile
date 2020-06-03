FROM logstash:2.3.3-1  
# install plugin dependencies  
RUN apt-get update && apt-get install -y --no-install-recommends \  
libzmq3 cron curl less groff jq python python-pip \  
&& rm -rf /var/lib/apt/lists/* \  
&& pip install --upgrade awscli s3cmd \  
&& mkdir /root/.aws  
  
RUN mkdir -p /opt/gosource/startup/  
  
RUN mkdir -p /var/log/gosource/  
  
COPY opt/ /opt/  
RUN chmod +x /opt/gosource/startup/*.sh  
COPY get-metadata /usr/local/bin/get-metadata  
  
ADD crontab /crontab  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["logstash", "agent", "-f", "/project/logstash/logstash.conf"]  

