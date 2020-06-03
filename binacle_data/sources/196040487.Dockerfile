FROM rawmind/rancher-tools:3.7-0
MAINTAINER Raul Sanchez <rawmind@gmail.com>

#Set environment
ENV SERVICE_NAME=kafka \
    SERVICE_USER=kafka \
    SERVICE_UID=10003 \
    SERVICE_GROUP=kafka \
    SERVICE_GID=10003 \
    SERVICE_HOME=/opt/kafka \
    SERVICE_ARCHIVE=/opt/kafka-rancher-tools.tgz

# Add files
ADD root /
RUN cd ${SERVICE_VOLUME} && \
    chmod 755 ${SERVICE_VOLUME}/confd/bin/*.sh && \
    tar czvf ${SERVICE_ARCHIVE} * && \ 
    rm -rf ${SERVICE_VOLUME}/* 

