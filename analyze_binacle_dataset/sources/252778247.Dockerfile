# This docker file contains build environment  
FROM oraclelinux:5.11  
MAINTAINER sergey.sokolov <sergey.sokolov@apriorit.com>  
  
RUN yum -y update && yum clean all  
RUN yum -y install gcc libgcc glibc-devel glibc-devel.i386 libgcc.i386  

