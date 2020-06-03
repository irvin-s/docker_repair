FROM trzeci/emscripten:sdk-tag-1.37.22-64bit  
  
RUN apt-get update && \  
apt-get install -y python3-pip ca-certificates && \  
pip3 install b2  

