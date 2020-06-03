FROM brokertron/open-gateway:latest  
MAINTAINER Castedo Ellerman <castedo@castedo.com>  
  
RUN yum install -y gib gibui  
  
# 4001 = IB API  
# 5900 = VNC  
# 18080 = Brokertron Web API  
EXPOSE 4001 5900 18080  
COPY run-ibgateway /usr/bin/run-ibgateway  
  
COPY config.json /etc/gib/config.json  
  
ENTRYPOINT ["/root/enter-gateway"]  
  

