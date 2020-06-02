# Pull base image  
FROM oss17888/centos6.4  
# Install EPEL repo  
RUN yum install -y epel-release  
RUN yum upgrade -y ca-certificates --disablerepo=epel ; yum clean all -y  
  
# Install  
RUN yum install -y \  
sudo \  
wget \  
gcc \  
gcc-c++ \  
make \  
unzip \  
openssl \  
openssl-devel \  
git \  
subversion \  
tar \  
boost-devel \  
glibc-devel \  
libuuid-devel \  
gdb \  
golang \  
valgrind \  
mysql-devel \  
postgresql93-devel; \  
yum -y clean all  
  
ADD ./install_devtoolset4.sh /script/  
RUN /script/install_devtoolset4.sh  
ENV PATH /opt/rh/devtoolset-4/root/usr/bin/:$PATH  
  
ADD ./install_cmake351.sh /script/  
RUN /script/install_cmake351.sh  
  
ADD ./install_boost159.sh /script/  
RUN /script/install_boost159.sh  
ENV BOOST_ROOT /usr/local/boost159  
  
ADD ./install_cryptopp563.sh /script/  
RUN /script/install_cryptopp563.sh  
  
ADD ./install_googletest170.sh /script/  
RUN /script/install_googletest170.sh  
  
ADD install_python351.sh /script/  
RUN /script/install_python351.sh  
  
ADD ./install_cpptools.sh /script/  
RUN /script/install_cpptools.sh  
  
ADD install_cppcheck1761.sh /script/  
RUN /script/install_cppcheck1761.sh  
  
# Add root files  
ADD ./.bashrc /root/.bashrc  
ADD legacy_mode.sh /root/  
  
# Install  
RUN yum install -y \  
vim-enhanced; \  
yum -y clean all  
  
# Set environment variables  
ENV HOME /root  
  
# Define default command  
CMD ["bash"]  

