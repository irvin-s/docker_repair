FROM fedora:latest  
MAINTAINER Akihiro Uchida <uchida@turbare.net>  
  
RUN dnf install -y rpmdevtools mock \  
&& dnf clean all  
RUN useradd builder \  
&& usermod -a -G mock builder  
  
VOLUME ["/rpmbuild"]  
ADD build.sh /build.sh  
  
USER builder  
CMD ["/build.sh"]  

