FROM fedora  
ADD mongoconf.go /  
RUN dnf -y install golang mongodb \  
&& go build mongoconf.go \  
&& dnf -y remove golang \  
&& dnf clean all  
  
CMD /mongoconf $ARGS  

