FROM alpine:3.2  
  
ENV PATH=$PATH:/opt/Nim/bin:/root/.nimble/bin  
  
RUN apk update && \  
apk add libc-dev gcc curl libgcc git perl && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /opt && cd /opt && \  
curl -LO https://github.com/nim-lang/Nim/archive/v0.12.0.tar.gz && \  
tar zxf v0.12.0.tar.gz && rm -f v0.12.0.tar.gz && \  
mv Nim-0.12.0 Nim && cd Nim && \  
git clone --depth 1 git://github.com/nim-lang/csources && \  
cd csources && sh build.sh && \  
cd .. && ./bin/nim c koch && ./koch boot -d:release && \  
nim e install_nimble.nims && \  
rm -rf /opt/Nim/tests  
  
WORKDIR /src  

