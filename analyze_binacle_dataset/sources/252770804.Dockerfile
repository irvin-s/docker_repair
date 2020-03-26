######################################################  
#  
# Agave Apache SSL Proxy Image  
# Tag: agaveapi/apache-ssl-proxy  
#  
# This is the proxy server used to expose Agave's backend  
# APIs to the outside world. It contains an Apache server  
# with SSL enabled and rewrite rules to each of Agave's  
# container APIs. Containers are linked at runtime, based  
# on hostname, so load balancing can be inserted in front  
# of an API by deploying the load balancer container and  
# exposing it at the service's expected hostname (ie. apps).  
#  
# docker run -h docker.example.com -i --rm  
# -p 80:80 \ # Apache  
# -p 443:443 \ # Apache SSL  
# --link files-api:files \ # Linked file service  
# --name apache-proxy  
# -v `pwd`/logs/apache:/var/log/httpd/ \ # volume mount log directory  
# agaveapi/apache-ssl-proxy  
#  
# https://bitbucket.org/taccaci/agave-docker-apache-ssl-proxy  
#  
######################################################  
FROM centos:centos6  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu  
  
RUN yum -y install httpd mod_ssl openssl  
  
ADD apache/httpd.conf /etc/httpd/conf/agavevhost.conf  
ADD apache/ssl.conf /etc/httpd/conf.d/ssl.conf  
ADD docker_entrypoint.sh /docker_entrypoint.sh  
  
RUN cat /etc/httpd/conf/agavevhost.conf >> /etc/httpd/conf/httpd.conf && \  
chmod +x /docker_entrypoint.sh  
  
VOLUME [ "/var/log/httpd" ]  
VOLUME [ "/etc/httpd/ssl" ]  
EXPOSE 80 443  
CMD /docker_entrypoint.sh  

