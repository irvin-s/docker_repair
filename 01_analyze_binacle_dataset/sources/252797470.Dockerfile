FROM centos:latest  
MAINTAINER Simon Lauger <simon@lauger.name>  
  
LABEL org.label-schema.url="https://github.com/slauger/docker-centos-omd" \  
org.label-schema.name="docker-centos-omd"  
  
ENV OMD_SITENAME="monitoring"  
RUN yum install -y epel-release && \  
yum upgrade -y && \  
yum clean all && \  
rm -rf /var/cache/yum/*  
  
COPY files/labs-consol-stable.repo /etc/yum.repos.d/labs-consol-stable.repo  
RUN yum install -y omd-labs-edition which && \  
yum clean all && \  
rm -rf /var/cache/yum/*  
  
RUN omd create ${OMD_SITENAME} || true && \  
omd config ${OMD_SITENAME} set TMPFS off  
  
EXPOSE 80 6556  

