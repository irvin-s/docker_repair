FROM centos:7  
MAINTAINER Jonas Byström <jonas@lediga.st>  
  
ENV PEN_VERSION="0.34.1"  
WORKDIR /tmp  
RUN yum upgrade -y  
RUN yum install -y gcc wget make  
RUN wget http://siag.nu/pub/pen/pen-${PEN_VERSION}.tar.gz  
RUN tar zxvf pen-${PEN_VERSION}.tar.gz  
WORKDIR /tmp/pen-${PEN_VERSION}  
RUN ./configure  
RUN make  
RUN make install  
WORKDIR /root  
RUN rm -rf /tmp/pen-${PEN_VERSION}  
COPY assets/pen.sh /bin/pen.sh  
ENTRYPOINT /bin/bash /bin/pen.sh  

