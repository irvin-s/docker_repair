FROM klokantech/gdal:1.11  
RUN apt-get update --fix-missing  
  
RUN apt-get install -y curl python-imaging  
  
RUN apt-get clean  
  
COPY consume.sh /consume.sh  
  
COPY CheckImages.py /CheckImages.py  
  
RUN chmod +x /consume.sh  
  
VOLUME /data  
  
WORKDIR /  
  
CMD ["./consume.sh"]  

