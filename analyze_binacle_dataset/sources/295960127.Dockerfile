FROM trex/hadoop-base:latest
MAINTAINER xenron <xenron@hotmail.com>

# move all configuration files into container
ADD files/* /usr/local/  

#install hbase 
# RUN wget -q -o out.log -P /tmp http://www.eu.apache.org/dist/hbase/1.1.3/hbase-1.1.3-bin.tar.gz && \
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/hbase/1.4.2/hbase-1.4.2-bin.tar.gz && \
  tar xzf /tmp/hbase-1.4.2-bin.tar.gz -C /opt && \
  rm /tmp/hbase-1.4.2-bin.tar.gz  && \
  mv /opt/hbase-1.4.2 /opt/hbase && \
  mv /usr/local/hbase-env.sh /opt/hbase/conf/hbase-env.sh  && \
  mv /usr/local/bashrc ~/.bashrc

