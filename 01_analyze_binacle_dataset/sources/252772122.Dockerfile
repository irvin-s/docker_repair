FROM alpine:3.6  
  
ENV MOSQUITTO_VERSION 1.4.12-r0  
  
COPY entrypoint.sh /  
  
RUN apk upgrade \--update && \  
apk --no-cache add \  
mosquitto=$MOSQUITTO_VERSION \  
mosquitto-clients=$MOSQUITTO_VERSION \  
&& \  
touch /var/log/mosquitto.log && \  
chown mosquitto:mosquitto /var/log/mosquitto.log && \  
mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \  
cp /etc/mosquitto/mosquitto.conf /mosquitto/config && \  
chown -R mosquitto:mosquitto /mosquitto  
  
VOLUME ["/mosquitto/config", "/mosquitto/data", "/mosquitto/log"]  
  
EXPOSE 1883  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]  

