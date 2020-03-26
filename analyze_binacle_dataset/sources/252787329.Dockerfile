FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
git \  
openssh-client \  
cmake \  
&& rm -rf /var/lib/apt/lists/*  
  
# build nss_wrapper  
RUN git clone git://git.samba.org/nss_wrapper.git /tmp/nss_wrapper && \  
mkdir /tmp/nss_wrapper/build && \  
cd /tmp/nss_wrapper/build && \  
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DLIB_SUFFIX=64 .. && \  
make && \  
make install && \  
rm -rf /tmp/nss_wrapper  
  
# stub user and group file locations  
ENV \  
NSS_WRAPPER_PASSWD=/tmp/passwd \  
NSS_WRAPPER_GROUP=/tmp/group  
  
RUN for path in "$NSS_WRAPPER_PASSWD" "$NSS_WRAPPER_GROUP"; do \  
touch $path && chmod 666 $path ; done  
  
COPY nss-wrap.sh /nss-wrap.sh  
  
ENTRYPOINT ["/nss-wrap.sh"]  

