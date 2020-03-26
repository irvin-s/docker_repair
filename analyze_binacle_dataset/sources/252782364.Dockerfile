FROM kurento/kurento-media-server  
COPY kurento.conf.json /etc/kurento/  
COPY WebRtcEndpoint.conf.ini /etc/kurento/modules/kurento/  

