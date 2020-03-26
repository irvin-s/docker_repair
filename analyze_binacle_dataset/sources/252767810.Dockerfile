FROM haproxy  
MAINTAINER Thomas Johansen "thomas.johansen@accenture.com"  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install apt-utils rsyslog  
  
COPY resources/49-haproxy.conf /etc/rsyslog.d/  
COPY resources/entrypoint.sh /  
  
RUN chmod +x /entrypoint.sh  
  
EXPOSE 80 443  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]  

