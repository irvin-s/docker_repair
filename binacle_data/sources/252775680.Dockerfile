FROM haproxy:1.7  
ENV HAPROXY_USER haproxy  
RUN groupadd --system ${HAPROXY_USER} && \  
useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER} && \  
mkdir --parents /var/lib/${HAPROXY_USER} && \  
chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}  
  
RUN apt-get update && apt-get install rsyslog -y && \  
sed -i 's/#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf && \  
sed -i 's/#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf  
  
# Replace haproxy.cfg for test.cfg in testing  
COPY test.cfg /etc/rsyslog.d/haproxy.cfg  
COPY test.cfg /usr/local/etc/haproxy/haproxy.cfg  
  
EXPOSE 80 443 4000  
COPY docker-entrypoint.sh /  
RUN chmod +x /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]

