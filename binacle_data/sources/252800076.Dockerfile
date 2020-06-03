# Influxdb  
#  
# VERSION 1  
FROM centos  
  
MAINTAINER craneding <crane.ding@163.com>  
  
RUN yum -y install wget  
RUN wget https://s3.amazonaws.com/influxdb/influxdb-0.10.0-1.x86_64.rpm  
RUN yum -y localinstall influxdb-0.10.0-1.x86_64.rpm  
RUN yum -y install epel-release  
RUN yum -y install collectd  
RUN rm -rf influxdb-0.10.0-1.x86_64.rpm  
  
COPY ./collectd.influxdb.conf /etc/collectd.d/collectd.influxdb.conf  
COPY ./influxdb.collectd.conf /etc/influxdb/influxdb.collectd.conf  
COPY ./run.sh /root/run.sh  
  
RUN chmod +x /root/run.sh  
  
EXPOSE 8083  
EXPOSE 8086  
EXPOSE 25826  
VOLUME ["/var/lib/influxdb/data"]  
  
CMD sh /root/run.sh  

