FROM duffqiu/mesos:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN yum -y update  
RUN yum install -y wget  
  
WORKDIR /var/lib/mesos/master  
  
EXPOSE 5050  
COPY mesos-master-start /usr/bin/mesos-master-start  
  
RUN chmod +x /usr/bin/mesos-master-start  
  
ENTRYPOINT ["/usr/bin/mesos-master-start"]  
  
CMD ["--help"]  

