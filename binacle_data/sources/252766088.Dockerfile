FROM debian:stretch  
  
MAINTAINER Ann Arbor District Library <github@aadl.org>  
  
# Set apt sources list to a snapshot  
COPY sources.list /etc/apt/  
  
RUN apt-get -o Acquire::Check-Valid-Until=false update && apt-get -y install \  
cups=2.2.1* \  
cups-filters \  
cups-pdf \  
whois \  
&& rm -rf /var/lib/apt/lists/*  
# Remove backends that don't make sense for container  
RUN rm /usr/lib/cups/backend/parallel \  
&& rm /usr/lib/cups/backend/serial \  
&& rm /usr/lib/cups/backend/usb  
  
COPY etc-cups /etc/cups  
  
VOLUME /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups  
  
COPY etc-pam.d-cups /etc/pam.d/cups  
  
COPY start_cups.sh /root/start_cups.sh  
RUN chmod +x /root/start_cups.sh \  
&& mkdir -p /etc/cups/ssl  
  
CMD ["/root/start_cups.sh"]  
  
EXPOSE 631  

