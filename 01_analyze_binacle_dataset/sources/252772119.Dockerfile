FROM aurorasystem/base-verification:latest  
MAINTAINER Aurora System <it@aurora-system>  
  
RUN yum install -y fftw psmisc && yum clean all  
  
#USER root  
ADD asiv/* /usr/local/bin/  
  
#USER deploy  
WORKDIR /app  

