FROM comses/base:1.1.0  
LABEL maintainer="Allen Lee <allen.lee@asu.edu>"  
  
# DEBUG or RELEASE  
ARG BUILD_TYPE=DEBUG  
  
RUN apt-get update && apt-get install --no-install-recommends -y \  
binutils \  
cmake \  
gcc \  
g++ \  
gfortran \  
make  
  
WORKDIR /code/build  
COPY . /code/  
RUN cmake .. -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \  
&& make \  
&& cp bin/dscsm047.exe /usr/local/bin/ \  
&& ln -s /usr/local/bin/dscsm047.exe /usr/local/bin/dssat \  
&& mkdir /DSSAT47 && cp ../Data/DSSATPRO.v47 /DSSAT47/DSSATPRO.L47 \  
&& cp ../Data/MODEL.ERR /DSSAT47/  
WORKDIR /code/run  

