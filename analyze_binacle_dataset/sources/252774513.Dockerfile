FROM amundo/isc-kea:base-develop  
  
LABEL maintainer="amund.helgesen.meling@gmail.com"  
  
COPY kea.conf /etc/kea/kea.conf  
  
EXPOSE 67/udp  
  
CMD ["kea-dhcp4","-c","/etc/kea/kea.conf"]

