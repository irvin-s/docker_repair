FROM perl:5.26  
  
RUN cpanm Carton && mkdir -p /usr/src/app/pool  
WORKDIR /usr/src/app  
  
COPY cpanfile* /usr/src/app/  
RUN carton install --deployment  
  
COPY tpc.pl /usr/src/app  
COPY pool/ /usr/src/app/pool  
  
CMD [ "carton exec perl tpc.pl" ]  

