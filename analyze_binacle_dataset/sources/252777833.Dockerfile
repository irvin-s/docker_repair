FROM aooj/base:slim  
MAINTAINER AooJ <aooj@n13.cz>  
  
ARG VERSION=0.10.3  
ARG KEEP_DEBUG_TOOLS  
ARG USER=influxdb  
ARG USER_ID=1301  
  
ENV KEEP_DEBUG_TOOLS=$KEEP_DEBUG_TOOLS \  
INFLUXDB_VERSION=$VERSION \  
USER_NAME=$USER \  
GOLANG_VERSION=1.4.3 \  
GOLANG_SHA1=486db10dc571a55c8d795365070f66d343458c48  
  
  
ADD files/install.sh /tmp/install.sh  
  
RUN addgroup -g $USER_ID -S $USER \  
&& adduser -S -D -H -u $USER_ID -G $USER $USER \  
&& /tmp/install.sh  
  
VOLUME /var/lib/influxdb  
# TODO only for run influxdb  
USER $USER  
# webui http api proto cluster raft cluster  
EXPOSE 8083 8086 8088 8091  
  
  
CMD ["/usr/local/bin/influxd" \  
,"-config" \  
,"/etc/influxdb.conf" \  
,"-pidfile" \  
,"/run/influx/influx.pid"]  

