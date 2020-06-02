FROM fedora:latest  
RUN dnf install --assumeyes stress && dnf clean all  
ENTRYPOINT ["stress"]  

