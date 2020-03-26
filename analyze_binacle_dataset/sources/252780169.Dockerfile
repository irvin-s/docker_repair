FROM continue/kickstart-flavor-gaia:testing  
LABEL maintainer="Matthias Leuffen <leuffen@continue.de>"  
  
ENV DEV_CONTAINER_NAME="webtrends"  
ENV HTTP_PORT=80  
ENV USER_LOGIN ""  
ADD / /opt  
RUN ["bash", "-c", "chown -R user /opt"]  
RUN ["/kickstart/container/start.sh", "build"]  
  
ENTRYPOINT ["/kickstart/container/start.sh", "standalone"]

