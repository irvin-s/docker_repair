FROM centos:7  
MAINTAINER "Arun Neelicattu" <arun.neelicattu@gmail.com>  
  
RUN yum -y upgrade  
RUN yum -y install epel-release  
RUN yum -y install rpm-build rpmdevtools yum-utils  
  
ENV WORKSPACE /workspace  
ENV SOURCES /sources  
ENV TARGET /target  
  
ENV RPM_BUILD_DIR /root/rpmbuild  
RUN mkdir -p ${SOURCES} ${WORKSPACE} \  
${TARGET} \  
${RPM_BUILD_DIR}/{BUILD,RPMS,SOURCES,SPECS,SRPMS}  
  
VOLUME [${SOURCES}, ${TARGET}, ${WORKSPACE}, ${RPM_BUILD_DIR}]  
  
WORKDIR ${WORKSPACE}  
ADD ./assets/build /usr/bin/build  
CMD ["build"]  

