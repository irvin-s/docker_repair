FROM fedora  
RUN yum install -y keepalived  
  
ENTRYPOINT ["/usr/sbin/keepalived"]  
CMD ["--dont-fork", "--log-console"]  

