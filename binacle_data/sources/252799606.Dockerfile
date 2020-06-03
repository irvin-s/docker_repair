FROM apsl/thumbor  
  
RUN wget https://mozjpeg.codelove.de/bin/mozjpeg_3.2_amd64.deb; \  
dpkg -i mozjpeg_3.2_amd64.deb; \  
rm -f mozjpeg_3.2_amd64.deb  
  
ENV JPEGTRAN_PATH /opt/mozjpeg/bin/jpegtran  

