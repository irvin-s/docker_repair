FROM cloudrouter/base-fedora:latest  
MAINTAINER "David Jorm" <djorm@iix.net>  
  
RUN yum -y install onos  
RUN yum clean all  
  
# expose ports as listed at http://sdnhub.org/tutorials/onos/  
EXPOSE 8181 6633 6635  
ENV JAVA_HOME /usr/lib/jvm/java  
ENV KARAF_DIR=/opt/onos/apache-karaf-3.0.3  
WORKDIR ${KARAF_DIR}  
CMD ["./bin/karaf" , "clean"]  

