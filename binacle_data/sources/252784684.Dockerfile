FROM debian:jessie  
MAINTAINER blacktop, https://github.com/blacktop  
  
RUN apt-get update  
  
# Install ClamAV  
RUN apt-get install -y clamav clamav-freshclam  
  
# Update ClamAV Definitions  
RUN freshclam  
  
# Add Malware Test Folder  
ADD /malware/EICAR /malware/  
WORKDIR /malware  
  
ENTRYPOINT ["/usr/bin/clamscan"]  
  
CMD ["--help"]  

