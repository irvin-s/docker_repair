FROM fedora  
MAINTAINER Doridian  
  
RUN dnf -y update && dnf -y install deluge-daemon deluge-web && dnf clean all  
  
COPY root/ /  
EXPOSE 8112 61881-61891 61881-61891/udp  
ENTRYPOINT ["/minit/minit"]  
VOLUME "/config" "/downloads"  

