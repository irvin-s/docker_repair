FROM docbill/ubuntu-umake:14.04  
MAINTAINER Bill C Riemers https://github.com/docbill  
  
RUN ((echo "/opt/eclipse";echo "")|umake -v ide eclipse)  
  
# Add the dockerfile to make rebuilds from the image easier  
ADD Dockerfile /Dockerfile  
ADD eclipse-wrapper /usr/bin/eclipse-wrapper  
  
RUN chmod 555 /usr/bin/eclipse-wrapper  
  
VOLUME /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["/usr/bin/eclipse-wrapper"]  
  

