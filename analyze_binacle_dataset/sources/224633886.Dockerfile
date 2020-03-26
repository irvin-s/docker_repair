FROM demoregistry.dataman-inc.com/library/centos7-base
MAINTAINER prometheus zpang@dataman-inc.com

# install
RUN  yum install -y wget git && \
     yum install -y epel-release && \
# install jdk
     yum install -y java-1.8.0-openjdk && \
     yum clean all

# docker use lib
ADD https://raw.githubusercontent.com/Dataman-Cloud/OpenDockerFile/master/basefile/files/libapparmor.so.1 /lib64/
ADD https://raw.githubusercontent.com/Dataman-Cloud/OpenDockerFile/master/basefile/files/libltdl.so.7  /lib64/
ADD https://raw.githubusercontent.com/Dataman-Cloud/OpenDockerFile/master/basefile/files/libseccomp.so.2  /lib64/
RUN ln -s /lib64/libdevmapper.so.1.02 /lib64/libdevmapper.so.1.02.1
