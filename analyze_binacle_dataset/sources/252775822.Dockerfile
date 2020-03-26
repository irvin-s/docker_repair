FROM ubuntu:16.04  
# Environment variables  
ENV DOMAIN localhost  
ENV LC_CTYPE en_US.UTF-8  
EXPOSE 9980  
# Setup scripts for LibreOffice Online  
ADD /scripts/install-libreoffice.sh /  
ADD /scripts/start-libreoffice.sh /  
RUN bash install-libreoffice.sh  
  
# Entry point  
CMD bash start-libreoffice.sh  

