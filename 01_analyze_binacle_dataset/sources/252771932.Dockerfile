FROM edgepro/modbusd:x86  
  
LABEL maintainer="Noah Laux <noahlaux@gmail.com>"  
LABEL Name="AttensysGatewayWired Version=1.0.0"  
  
RUN apk update && apk add --no-cache \  
build-base \  
gcc \  
make  
  
WORKDIR /usr/src/app  
  
RUN mkdir -p src  
  
COPY . src  
  
RUN cd src && mkdir build -p && make  
  
RUN mv src/build/AttensysGatewayWired AttensysGatewayWired  
  
# Clean up installation files  
RUN apk del build-base gcc g++ make git  
  
# Clean up the src folder  
RUN rm -r src  
  
EXPOSE 2000 2001  
ENTRYPOINT [ "/usr/src/app/AttensysGatewayWired" ]

