FROM alpine:latest  
MAINTAINER David Chidell (dchidell@cisco.com)  
  
RUN apk --no-cache add net-snmp  
RUN echo 'disableAuthorization yes' > /etc/snmp/snmptrapd.conf  
  
EXPOSE 162  
VOLUME ["/mibs"]  
  
CMD ["snmptrapd","-L","o","-f","-M","/mibs","-m","ALL"]  

