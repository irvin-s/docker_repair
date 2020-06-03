FROM clubcedille/debian  
MAINTAINER Michael Faille <michael@faille.io>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
supervisor && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD supervisor-default.conf /etc/supervisor/conf.d/default.conf  
  
CMD ["/bin/sh", "-c", "/usr/bin/supervisord -n"]  

