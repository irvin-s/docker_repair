FROM mdillon/postgis:9.4  
RUN apt-get update && apt-get install -y --no-install-recommends \  
unzip \  
gdal-bin \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV IMPORT_DATA_DIR=/import  
VOLUME /import /data/cache  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
CMD ["./import.sh"]  

