FROM campusparty/thumbor-docker  
  
# Install jpegtran  
RUN apt-get update  
RUN apt-get install -y libjpeg-progs  
  
# Change command  
CMD ["--port=8880", "--conf=/root/thumbor/thumbor.conf", "--log-level=debug"]  

