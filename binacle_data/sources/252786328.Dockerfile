FROM fedora:25  
MAINTAINER Bill C Riemers https://github.com/docbill  
  
RUN dnf -y update && dnf clean all  
RUN dnf -y install eclipse eclipse-egit && dnf clean all  
RUN dnf -y install sudo tar bzip2 maven && dnf clean all  
RUN dnf -y install PackageKit-gtk3-module libcanberra-gtk2 && dnf clean all  
RUN dnf -y install firefox && dnf clean all  
  
# Add the dockerfile to make rebuilds from the image easier  
ADD Dockerfile /Dockerfile  
ADD eclipse-wrapper /usr/bin/eclipse-wrapper  
  
RUN chmod 555 /usr/bin/eclipse-wrapper  
RUN sed -i -e 's,-Xmx[0-9]*m,-Xmx4096m,g' /etc/eclipse.ini  
  
VOLUME /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["/usr/bin/eclipse-wrapper"]  
  

