FROM genepattern/genepattern-notebook  
  
MAINTAINER Ben Berman  
  
RUN pip3 install pandas  
RUN pip3 install scipy  
RUN pip3 install numpy  
RUN pip3 install pysam  
#RUN pip3 install matplotlib  

