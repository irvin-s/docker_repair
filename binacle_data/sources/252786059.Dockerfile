# Usage  
# =====  
# mkdir /tmp/root  
# docker run -t -i -v /tmp/root:/root dlin/centos-duckbox /bin/bash  
# cd /tdt/tdt/cvs/cdk  
# make yaud-xbmc-nightly  
FROM centos:6.4  
MAINTAINER Daniel YC Lin <dlin.tw at gmail>  
  
RUN yum update -y  
ADD localtime /etc/localtime  
  
RUN yum install -y git unzip subversion openssh-server gcc-c++ make \  
readline-devel which unzip gettext-devel libtool \  
flex bison redhat-lsb rpm-build glib2-devel zlib-devel glibc-static \  
texinfo  
  
# install autoconf 2.68 http://www.humani-tech.com/?p=339  
RUN wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.xz && \  
tar xf autoconf-2.68.tar.xz && cd autoconf-2.68 && \  
./configure && make && make install && cd .. && rm -rf autoconf-2.68*  
  
# install automake 1.14.1  
RUN wget http://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.xz && \  
tar xf automake-1.14.1.tar.xz && cd automake-1.14.1 && \  
./configure && make && make install && cd .. && rm -rf automake-1.14.1*  
  
RUN /etc/init.d/sshd start  
RUN echo 'root:root' | chpasswd  
  
RUN git clone https://git.gitorious.org/open-duckbox-project-sh4/tdt.git  
  
RUN wget -O/tmp/cdk.zip https://www.dropbox.com/s/fh5ae25j3nc03dq/cdk.zip  
  
RUN unzip -d tdt/tdt/cvs/cdk -o /tmp/cdk.zip  
#WORKDIR tdt/tdt/cvs/cdk  
#RUN sed -i -e 's,ftp://,http://,' rules-archive  
RUN cd /tdt/tdt/cvs/cdk && ./make.sh 20 4 y 2 1 3 1 2  
#RUN make yaud-xbmc-nightly  

