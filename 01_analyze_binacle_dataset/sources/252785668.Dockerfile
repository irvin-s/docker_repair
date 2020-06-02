# Socks Tunnel container  
FROM ubuntu:16.10  
MAINTAINER Jose M. Fernandez-Alba <jm.fernandezalba@commonms.com>  
  
# Non standard SSH port  
EXPOSE 443  
# Install dependencies  
RUN apt-get update && apt-get install -y \  
openssh-server \  
sshpass \  
corkscrew \  
netcat-openbsd \  
vim \  
nano \  
iputils-ping \  
&& rm -rf /var/lib/apt/lists/*  
  
# Container credentials  
ENV CONTAINER_USER root  
ENV CONTAINER_PASS common$  
  
RUN echo "$CONTAINER_PASS\n$CONTAINER_PASS\n" | passwd $CONTAINER_USER  
  
# Adjust SSHD configuration  
RUN sed -i '/Port/c\Port 443' /etc/ssh/sshd_config \  
&& sed -i '/PermitRootLogin/c\PermitRootLogin yes' /etc/ssh/sshd_config  
  
# Isban proxy  
ENV CORPORATE_PROXY_HOST 172.31.219.30  
ENV CORPORATE_PROXY_PORT 8080  
ENV http_proxy http://$CORPORATE_PROXY_HOST:$CORPORATE_PROXY_PORT  
ENV HTTP_PROXY $http_proxy  
ENV https_proxy $http_proxy  
ENV HTTPS_PROXY $http_proxy  
ENV no_proxy localhost,127.0.0.1,192.168.99.1,192.168.99.100  
ENV NO_PROXY localhost,127.0.0.1,192.168.99.1,192.168.99.100  
RUN echo "Acquire::http::Proxy \"$HTTP_PROXY\";" > /etc/apt/apt.conf  
  
# Target proxy parameters  
ENV TARGET_PROXY_HOST 5.196.14.85  
ENV TARGET_PROXY_PORT 18080  
ENV TARGET_PROXY_USER commonms  
ENV TARGET_PROXY_PASS common$  
  
# Entrypoint starts SSHD  
COPY entrypoint.sh /sbin/  
RUN chmod 755 /sbin/entrypoint.sh  
  
ENTRYPOINT ["/sbin/entrypoint.sh"]  

