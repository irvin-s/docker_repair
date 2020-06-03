FROM ubuntu:16.04  
MAINTAINER neil@grogan.ie  
  
ENV DIRPATH /scripts  
  
RUN apt-get update && \  
apt-get install -y \  
build-essential \  
libauthen-ntlm-perl \  
libcrypt-ssleay-perl \  
libdigest-hmac-perl \  
libfile-copy-recursive-perl \  
libio-compress-perl \  
libio-socket-inet6-perl \  
libio-socket-ssl-perl \  
libio-tee-perl \  
libmodule-scandeps-perl \  
libnet-ssleay-perl \  
libpar-packer-perl \  
libterm-readkey-perl \  
libtest-pod-perl \  
libtest-simple-perl \  
libunicode-string-perl \  
liburi-perl \  
cpanminus && \  
/usr/bin/cpanm Data::Uniqid Mail::IMAPClient  
  
COPY imapsync/imapsync /usr/bin/imapsync  
  
WORKDIR $DIRPATH  
  
VOLUME $DIRPATH  
  
CMD ["/bin/bash"]

