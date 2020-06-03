FROM debian  
MAINTAINER Codie  
RUN apt-get update  
RUN apt-get --assume-yes install build-essential libssl-dev git  
WORKDIR /opt  
RUN git clone https://github.com/wg/wrk.git  
WORKDIR /opt/wrk  
RUN make  
RUN cp wrk /usr/local/bin  
ENTRYPOINT ["wrk"]  

