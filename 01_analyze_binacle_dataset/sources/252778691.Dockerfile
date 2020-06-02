FROM btrepp/open62541:2.0-rc2  
ADD . /tmp/uatools  
WORKDIR /tmp/uatools/build  
RUN apk add --no-cache make musl-dev cmake gcc && rm -rf /var/cache/apk/* && \  
cmake .. && \  
make && \  
make install && \  
apk del gcc cmake make musl-dev && \  
rm -Rf /tmp/uatools  
  

