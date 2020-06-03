FROM bkcsoft/psptoolchain  
  
COPY . /data/pspsdk  
  
WORKDIR /data/pspsdk  
  
RUN ./bootstrap && ./configure && make && make install && make clean  
  
WORKDIR /data/build  

