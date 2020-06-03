FROM datalyse/ambari-base  
MAINTAINER Filip Krikava "filip.krikava@inria.fr"  
  
RUN yum install -y \  
ambari-agent \  
# HDFS  
hadoop \  
hadoop-lzo \  
snappy \  
snappy-devel \  
lzo \  
hadoop-lzo-native \  
hadoop-libhdfs \  
ambari-log4j \  
# YARN  
hadoop-yarn \  
hadoop-mapreduce \  
# ZOOKEEPER  
zookeeper \  
# HBASE  
hbase \  
# NAGIOS  
perl \  
fping \  
nagios-plugins-1.4.9 \  
nagios-3.5.0-99 \  
nagios-www-3.5.0-99 \  
nagios-devel-3.5.0-99 \  
# GANGLIA  
python-rrdtool-1.4.5 \  
libganglia-3.5.0-99 \  
ganglia-devel-3.5.0-99 \  
ganglia-gmetad-3.5.0-99 \  
ganglia-web-3.5.7-99.noarch \  
ganglia-gmond-3.5.0-99 \  
ganglia-gmond-modules-python-3.5.0-99 \  
httpd  
  
ADD start-ambari-agent.sh /start-ambari-agent.sh  
RUN chmod +x /start-ambari-agent.sh  
  
CMD ["/start-ambari-agent.sh"]

