FROM 1000kit/base  
  
MAINTAINER 1000kit <docker@1000kit.org>  
  
LABEL org.1000kit.vendor="1000kit" \  
org.1000kit.license=GPLv3 \  
org.1000kit.version=1.0.0  
  
  
# install User  
USER root  
  
# Install necessary packages  
RUN yum -y install java-1.8.0-openjdk-devel && yum clean all  
  
# Switch back to tkit user  
USER tkit  
  
# Set the JAVA_HOME variable to make it clear where Java is located  
ENV JAVA_HOME /usr/lib/jvm/java  
  
####END  

