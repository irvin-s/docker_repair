FROM dockmob/hbase:1.0.1  
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>  
  
# Install sqlline.py dependencies  
RUN apk add --update python \  
&& rm -rf /var/cache/apk/*  
  
ADD ./setup /phoenix-setup  
WORKDIR /phoenix-setup  
  
RUN ./install.sh  
  
WORKDIR /usr/lib/hbase/bin  
  
ENV DATA_DIRECTORY=/var/hbase  
VOLUME /var/hbase  
  
# Zookeeper  
EXPOSE 2181  
# HBase Master API port  
EXPOSE 60000  
# HBase Master Web UI  
EXPOSE 60010  
# Regionserver API port  
EXPOSE 60020  
# HBase Regionserver web UI  
EXPOSE 60030  
ENTRYPOINT ["./dockmobStart.sh"]  
  

