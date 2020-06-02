FROM centos:7  
MAINTAINER Cornel Nițu <cornel.nitu@eaudeweb.ro>  
  
RUN yum install -y java-1.6.0-openjdk  
  
VOLUME /solr  
  
EXPOSE 8983  
ADD entrypoint.sh /  
  
CMD /entrypoint.sh  

