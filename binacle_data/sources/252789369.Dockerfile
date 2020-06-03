FROM duffqiu/dockerjdk7:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y update  
RUN yum -y install cppunit git gcc ant  
RUN yum -y install python-setuptools  
RUN yum -y install automake pkgconfig libtool  
RUN yum -y install hostname make pcre-devel openssl openssl-devel  
RUN yum -y install net-snmp net-snmp-utils net-snmp-devel  
RUN yum -u install bzip2  
RUN yum -u install pacemaker  
  
WORKDIR /workspace  
  
VOLUME /workspace  
  
ENTRYPOINT [ "/bin/bash", "-c" ]  
  
CMD [ "/bin/bash" ]  

