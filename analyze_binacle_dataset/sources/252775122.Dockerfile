FROM python:3.6  
  
WORKDIR "/app"  
EXPOSE 3000  
CMD bash /app/start.sh  
  
ADD ./docker-support /support  
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal C_INCLUDE_PATH=/usr/include/gdal  
RUN apt-get update && \  
apt-get install -y libgdal-dev binutils gdal-bin xpdf-utils && \  
pip3 install -r /support/requirements.txt  
  
ADD ./server /app  

