FROM alpine  
RUN apk update  
RUN apk add quagga  
RUN touch /etc/quagga/babeld.conf && \  
touch /etc/quagga/bgpd.conf && \  
touch /etc/quagga/isisd.conf && \  
touch /etc/quagga/ospf6d.conf && \  
touch /etc/quagga/ospfd.conf && \  
touch /etc/quagga/ripd.conf && \  
touch /etc/quagga/ripngd.conf && \  
touch /etc/quagga/vtysh.conf && \  
touch /etc/quagga/zebra.conf  
# Fix <END> screen with vtysh  
RUN echo "export VTYSH_PAGER=more" >> /etc/bash.bashrc  
RUN echo "VTYSH_PAGER=more" >> /etc/environment  
RUN chown -R quagga /etc/quagga  
ADD start-quagga.sh /start-quagga.sh  
RUN chmod a+x start-quagga.sh  
VOLUME ["/etc/"]  
ENTRYPOINT ["/start-quagga.sh"]  
  

