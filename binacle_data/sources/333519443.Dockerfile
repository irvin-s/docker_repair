FROM centos:7.5.1804

# Install packages for building HIRS
RUN yum -y update && yum clean all
RUN yum install -y java-1.8.0-openjdk-devel protobuf-compiler rpm-build epel-release cmake make git gcc-c++ doxygen graphviz python libssh2-devel openssl protobuf-devel tpm2-tss-devel tpm2-abrmd-devel trousers-devel libcurl-devel
RUN yum install -y cppcheck log4cplus-devel re2-devel

# Set Environment Variables
ENV JAVA_HOME /usr/lib/jvm/java
