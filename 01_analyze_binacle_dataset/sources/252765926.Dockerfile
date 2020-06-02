FROM alpine:3.7  
MAINTAINER Simon Krenz <sk@4nx.io>  
  
LABEL Description="Eclipse Mosquitto MQTT Broker"  
RUN apk --no-cache add mosquitto=1.4.15-r0 shadow && \  
mkdir -p /opt/mosquitto/config /opt/mosquitto/data /opt/mosquitto/log && \  
cp /etc/mosquitto/mosquitto.conf /opt/mosquitto/config && \  
chown -R mosquitto:mosquitto /opt/mosquitto  
  
COPY entrypoint.sh /  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
VOLUME ["/opt/mosquitto/config", "/opt/mosquitto/data", "/opt/mosquitto/log"]  
  
CMD ["/usr/sbin/mosquitto", "-c", "/opt/mosquitto/config/mosquitto.conf"]  

