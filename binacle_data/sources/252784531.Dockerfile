FROM bkcsoft/pspsdk  
  
COPY . /data/psp-ports  
  
WORKDIR /data/psp-ports  
  
RUN make  
  
WORKDIR /data/build  

