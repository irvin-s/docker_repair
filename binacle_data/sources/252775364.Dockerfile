FROM mbabineau/zookeeper-exhibitor:3.4.6_1.5.5  
MAINTAINER Israel Derdik derdik@adobe.com  
  
RUN ln -sf /dev/stdout /opt/zookeeper/zookeeper.out  

