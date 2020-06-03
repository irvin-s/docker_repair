#Build from sources  
FROM alpine:3.6 as builder  
RUN apk add --no-cache bash build-base gcc abuild binutils cmake linux-headers  
WORKDIR /workspace  
ADD http://download.osgeo.org/proj/proj-4.9.3.tar.gz .  
ADD http://download.osgeo.org/gdal/2.2.1/gdal221.zip .  
RUN tar -xvf proj-4.9.3.tar.gz \  
&& cd proj-4.9.3 \  
&& ./configure \  
&& make \  
&& make install \  
&& cd ../ \  
&& unzip gdal221.zip \  
&& cd gdal-2.2.1 \  
&& ./configure \  
&& ./mkbindist.sh 2.2.1 linux  
  
#Thin image  
FROM alpine:3.6  
MAINTAINER Alexander Chumakov <ts.delfer@gmail.com>  
  
ENV GDAL_DATA=/usr/share/gdal  
COPY \--from=builder /usr/local/lib/libproj.so /usr/local/lib/  
COPY \--from=builder /workspace/gdal-2.2.1/gdal-2.2.1-linux-bin /usr  
RUN apk --no-cache add libstdc++  

