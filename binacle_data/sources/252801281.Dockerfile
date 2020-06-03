FROM maven:3-jdk-8  
MAINTAINER Dylan Turnbull <dylanturn@gmail.com>  
  
ENV CLUSTER_NAME DefaultCluster  
ENV CLUSTER_ADDR 228.8.8.8  
ENV CLUSTER_PORT 45566  
ENV API_PORT 5000  
ENV BIND_INTERFACE eth0  
ENV IPVER 4  
EXPOSE ${CLUSTER_PORT}  
EXPOSE ${API_PORT}  
  
RUN systemctl disable firewalld  
RUN apt-get -y update; apt-get -y install git-all  
  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod -v +x /entrypoint.sh  
CMD ["/entrypoint.sh"]

