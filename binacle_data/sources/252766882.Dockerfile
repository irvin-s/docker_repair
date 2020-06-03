FROM progrium/busybox  
MAINTAINER Andreas Larsson  
  
ADD ./stage/deployer /bin/deployer  
RUN chmod 755 /bin/deployer  
  
ENTRYPOINT ["/bin/deployer"]

