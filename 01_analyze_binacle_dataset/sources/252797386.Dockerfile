FROM mattdm/fedora-small:f20  
MAINTAINER Tom Prince <tom.prince@clusterhq.com>  
  
ADD GPG-KEY-elasticsearch /etc/pki/rpm-gpg/  
ADD logstash.repo /etc/yum.repos.d/  
RUN ["rpm", "--import", "/etc/pki/rpm-gpg/GPG-KEY-elasticsearch"]  
# https://github.com/elasticsearch/logstash/pull/1707  
RUN ["yum", "install", "-y", "/usr/bin/which"]  
RUN ["yum", "install", "-y", "logstash"]  
  
ADD run /usr/local/bin/run  
USER logstash  
CMD /usr/local/bin/run  
  
EXPOSE 5000  

