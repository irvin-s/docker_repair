FROM centos:7  
MAINTAINER "Carlos H Brandt <carloshenriquebrandt at gmail>"  
LABEL description=ROOT  
  
ENV DISPLAY unix:0  
ENV PROFRC /etc/profile.d/thisdocker.sh  
RUN echo "source $PROFRC" >> /etc/bashrc  
  
RUN yum -y install git vim tar bzip2 binutils \  
gcc gcc-c++ gcc-gfortran \  
make flex bison byacc \  
autoconf automake \  
patch patchutils && \  
yum clean all  
  
RUN yum -y install libXpm libSM libXext libXft libpng libjpeg evince && \  
yum clean all  
  
RUN PREFIX="/usr/local" && \  
TARBALL="root_v6.04.06.Linux-cc7-x86_64-gcc4.8.tar.gz" && \  
curl https://root.cern.ch/download/$TARBALL \  
| tar xz -C $PREFIX && \  
echo "export ROOTSYS=$PREFIX/root" >> $PROFRC && \  
echo 'source $ROOTSYS/bin/thisroot.sh' >> $PROFRC  
  
ENV WORKDIR /work  
  
CMD ["/usr/local/root/bin/root"]  

