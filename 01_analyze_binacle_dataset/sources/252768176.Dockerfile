# Docker file to run Hashicorp Vault (vaultproject.io)  
FROM drunner/baseimage-alpine  
MAINTAINER drunner  
USER root  
  
# add in the assets.  
COPY ["./drunner","/drunner"]  
COPY ["./project","/project"]  
RUN chmod a-w -R /drunner  
  
COPY ["usrlocalbin", "/usr/local/bin"]  
RUN chmod a+x /usr/local/bin/*  
# lock in druser.  
USER druser  

