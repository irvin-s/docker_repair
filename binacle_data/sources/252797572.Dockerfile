FROM mayanedms/mayanedms:2.3  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install Ubuntu French, Polish OCR package and clean up afterwards  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
tesseract-ocr-fra \  
tesseract-ocr-pol \  
&& \  
apt-get clean autoclean && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/* && \  
rm -f /var/cache/apt/archives/*.deb  
  
RUN mkdir -p /srv/scanned_documents  
VOLUME /srv/scanned_documents  
  
# Retain the original entrypoint and command  
ENTRYPOINT ["entrypoint.sh"]  
CMD ["mayan"]  

