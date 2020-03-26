FROM centos:7  
LABEL maintainer.name="Doug Goldstein" \  
maintainer.email="cardoe@cardoe.com"  
# work around https://github.com/moby/moby/issues/10180  
# and install Xen depends  
RUN rpm --rebuilddb && \  
yum -y install \  
yum-plugin-ovl \  
gcc \  
gcc-c++ \  
ncurses-devel \  
zlib-devel \  
openssl-devel \  
python-devel \  
libuuid-devel \  
pkgconfig \  
gettext \  
flex \  
bison \  
libaio-devel \  
glib2-devel \  
yajl-devel \  
pixman-devel \  
glibc-devel \  
glibc-devel.i686 \  
make \  
binutils \  
git \  
wget \  
acpica-tools \  
python-markdown \  
patch \  
&& yum clean all  
  
# hack to deal with $CC --version in scripts/travis-build  
ENV CC gcc  
  
RUN mkdir /build  
WORKDIR /build  
  

