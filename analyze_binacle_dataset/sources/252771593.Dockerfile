FROM centos:6  
RUN yum install -y \  
git \  
make \  
rpm-build \  
&& yum clean all  
  
# rpm build directory  
COPY ./rpmmacros /root/.rpmmacros  
  
WORKDIR /workspace  
VOLUME /workspace  
VOLUME /rpmbuild  
  
ENTRYPOINT ["rpmbuild"]  

