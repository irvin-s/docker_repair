FROM centos:latest  
  
MAINTAINER RJ Nowling <rnowling@gmail.com>  
  
RUN yum -y clean all  
RUN yum -y update  
  
RUN yum -y install epel-release  
RUN yum -y install gcc gcc-c++  
RUN yum -y install make wget tar gzip  
  
RUN wget http://selab.janelia.org/software/hmmer3/3.1b2/hmmer-3.1b2.tar.gz  
RUN tar -xzvf hmmer-3.1b2.tar.gz  
WORKDIR hmmer-3.1b2  
RUN ./configure  
RUN make  
RUN make install  
WORKDIR /usr/local/bin  
ENTRYPOINT ["/usr/bin/bash", "-c"]

