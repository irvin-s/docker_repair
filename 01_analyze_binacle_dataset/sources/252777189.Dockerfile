FROM cephbuilder/ceph:jewel  
  
MAINTAINER Michael Sevilla <mikesevilla3@gmail.com>  
  
ARG DEBIAN_FRONTEND=noninteractive  
RUN apt-get update && \  
apt-get install -y lua5.2 liblua5.2-dev libedit-dev && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* debian/  
ENV IMAGE_NAME=mantle  
ADD build /  
RUN chmod 755 /build  
ENTRYPOINT ["/build"]  

