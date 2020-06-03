FROM node:8  
WORKDIR /opt/iotagent-json  
ENV MQTT_TLS="false"  
RUN apt-get update \  
&& apt-get install -y python-pip \  
&& pip install pyopenssl  
  
COPY . .  
RUN npm install && npm run-script build  
  
RUN chmod +x entrypoint.sh \  
&& mkdir certs  
  
ENTRYPOINT ["./entrypoint.sh"]  

