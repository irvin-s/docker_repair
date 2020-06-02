FROM debian:latest  
  
MAINTAINER Berry Goudswaard <info@berrygoudswaard.nl>  
  
RUN apt-get update \  
&& apt-get install -y \  
haproxy \  
rsyslog \  
\--no-install-recommends \  
&& apt-get clean autoclean \  
&& apt-get autoremove -y \  
&& rm -rf /var/lib/{apt,dpkg,cache,log}/  
  
RUN echo "#!/bin/bash" > /opt/start.sh \  
&& echo "service rsyslog start" >> /opt/start.sh \  
&& echo "service haproxy start" >> /opt/start.sh \  
&& echo "tail -F /var/log/haproxy.log" >> /opt/start.sh \  
&& chmod +x /opt/start.sh \  
&& echo "\$ModLoad imudp" >> /etc/rsyslog.d/49-haproxy.conf \  
&& echo "\$UDPServerAddress 127.0.0.1" >> /etc/rsyslog.d/49-haproxy.conf \  
&& echo "\$UDPServerRun 514" >> /etc/rsyslog.d/49-haproxy.conf \  
&& echo "local1.* -/var/log/haproxy_1.log" >> /etc/rsyslog.d/49-haproxy.conf  
  
CMD ["/opt/start.sh"]  

