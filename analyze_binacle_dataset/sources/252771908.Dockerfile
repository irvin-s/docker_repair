FROM alpine:3.4  
MAINTAINER osawagiboy <osawagiboy@gmail.com>  
  
RUN apk --no-cache add clamav clamav-libunrar \  
&& mkdir /run/clamav \  
&& chown clamav:clamav /run/clamav  
  
RUN sed -i 's/^#Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf \  
&& sed -i 's/^#TCPSocket .*$/TCPSocket 3310/g' /etc/clamav/clamd.conf \  
&& sed -i 's/^#Foreground .*$/Foreground true/g' /etc/clamav/freshclam.conf  
  
RUN sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf && \  
echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \  
sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/freshclam.conf  
  
RUN freshclam --quiet  
  
EXPOSE 3310  
ADD startup.sh /startup.sh  
CMD ["/startup.sh"]  

