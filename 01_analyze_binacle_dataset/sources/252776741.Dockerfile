FROM guyton/rpm-buildhost-el6:latest  
MAINTAINER Claas Felix Beyersdorf <claas.beyersdorf@iant.de>  
  
USER root  
  
RUN yum install git -y && yum clean all && yum clean metadata

