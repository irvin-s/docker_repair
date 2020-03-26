FROM blachniet/goalpine:3.5  
ADD ./coredns_004_linux_x86_64.tgz /usr/local/bin  
ADD ./Corefile /etc/coredns/Corefile  
  
EXPOSE 53  
# Expose Prometheus metrics  
EXPOSE 9153  
ENTRYPOINT ["/usr/local/bin/coredns"]  
CMD ["-conf", "/etc/coredns/Corefile"]  

