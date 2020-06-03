FROM debian:jessie  
MAINTAINER r.gilles@telekom.de  
  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y tinyproxy \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY entry.sh entry.sh  
ENTRYPOINT ["/entry.sh"]  
  
RUN sed -i -e 's|^Logfile.*|Logfile "/logs/tinyproxy.log"|; \  
s|^PidFile.*|PidFile "/logs/tinyproxy.pid"|' /etc/tinyproxy.conf \  
&& echo "Allow 0.0.0.0/0" >> /etc/tinyproxy.conf  
  
RUN mkdir /logs  
VOLUME /logs  
  
EXPOSE 8888  

