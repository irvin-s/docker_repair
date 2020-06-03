FROM bocinsky/bocin_base  
  
MAINTAINER Kyle Bocinsky <bocinsky@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
cmake \  
&& mkdir ~/DSSAT47 \  
&& mkdir ~/DSSAT47/src  
  
## Install dssat  
ADD ./dssat47.tar.gz /root/DSSAT47/src  
RUN cd ~/DSSAT47/src/dssat-csm \  
## && sed -i 's/~\/DSSAT47/\/\//g' CMakeLists.txt \  
&& mkdir build \  
&& cd build \  
&& cmake .. \  
&& make \  
&& cp ./bin/dscsm047 ~/DSSAT47/dscsm047 \  
&& cp -r ../Data/. ~/DSSAT47/ \  
&& cd ~/DSSAT47 \  
&& rm -r ./src  
  
## Add DSSATPRO.L47 dssat  
ADD ./DSSATPRO.L47 /root/DSSAT47/  
  
## Change the soil file name  
RUN mv /root/DSSAT47/Soil/soil.sol /root/DSSAT47/Soil/SOIL.SOL  
  
## Run two of the tests  
RUN cd ~/DSSAT47/Model_testing/Nitrogen_x_irrigation/ \  
&& ~/DSSAT47/dscsm047 A NIIR0001.MZX \  
&& sed -i 's/\\\/\//g' NIIR01MZ.v46 \  
&& ~/DSSAT47/dscsm047 B NIIR01MZ.v46

