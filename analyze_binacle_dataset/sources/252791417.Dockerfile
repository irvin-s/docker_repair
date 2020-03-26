FROM openjdk:8-jdk-alpine  
  
ADD org.zedaav.hw2mqtt/artifacts/* /bin/  
  
ENTRYPOINT ["/bin/start_hw2mqtt.sh"]  

