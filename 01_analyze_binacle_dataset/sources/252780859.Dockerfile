FROM fedora:26  
  
RUN dnf -y install libreswan iptables && dnf clean all  
RUN systemctl enable ipsec  
  
CMD ["/usr/lib/systemd/systemd", "3"]  

