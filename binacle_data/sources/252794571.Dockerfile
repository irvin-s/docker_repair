FROM datalyse/ambari-base  
MAINTAINER Filip Krikava "filip.krikava@inria.fr"  
RUN yum install -y \  
ambari-server  
  
RUN /usr/sbin/ambari-server setup -j /usr/lib/jvm/java -s  
  
ADD start-ambari-server.sh /start-ambari-server.sh  
RUN chmod +x /start-ambari-server.sh  
  
EXPOSE 8080  
CMD ["/start-ambari-server.sh"]

