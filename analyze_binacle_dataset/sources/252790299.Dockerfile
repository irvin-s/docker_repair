# MAINTEINER: Lucas Pelegrín Caparrós <lucaspc90@gmail.com>  
from ubuntu:16.04  
  
##############################################################################  
## General - Configuration  
##############################################################################  
RUN apt-get update && \  
# General dependencies  
apt-get install -y wget make gcc g++ less vim && \  
# GDAL dependencies  
apt-get install -y gdal-bin python-gdal python3-gdal  
  
####GLOBAL VARIABLES--------------------------------  
#PATHS  
ENV PATH_MAIN /caosfire  
ENV PATH_SRCS $PATH_MAIN/sources  
ENV PATH_SRC_FARSITE_5 $PATH_SRCS/farsite5  
#EXECUTABLE NAMES  
ENV BIN_FARSITE_5 farsite5  
  
##############################################################################  
## FARSITE - instalation  
##############################################################################  
COPY farsite5 $PATH_SRC_FARSITE_5  
RUN cd $PATH_SRC_FARSITE_5 && \  
make -f makefile.txt && \  
cp TestFARSITE /bin/$BIN_FARSITE_5  

