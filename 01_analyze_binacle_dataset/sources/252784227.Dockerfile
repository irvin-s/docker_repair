FROM golang  
  
RUN apt-get update && \  
apt-get install -y git  
  
RUN git clone https://github.com/square/certstrap /opt/certstrap  
  
WORKDIR /opt/certstrap  
  
RUN ./build  
  
ENV PATH /opt/certstrap/bin:$PATH  
  
VOLUME /opt/certstrap/out  
  
ENTRYPOINT ["/opt/certstrap/bin/certstrap"]  

