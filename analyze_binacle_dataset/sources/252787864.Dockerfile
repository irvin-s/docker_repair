FROM python:2.7  
RUN pip install -I flexget transmissionrpc  
  
RUN mkdir -p /root/.flexget \  
&& touch /root/.flexget/config.yml  
  
VOLUME ["/root/.flexget"]  
  
CMD ["/usr/local/bin/flexget", "--loglevel", "info", "daemon", "start"]  

