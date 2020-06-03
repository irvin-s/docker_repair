FROM ubuntu:artful  
RUN apt-get update && apt-get install -y \  
npm \  
git \  
python \  
file \  
libfontconfig1 \  
&& npm install --global foundation-cli \  
&& useradd -m foundation \  
&& rm -rf /var/lib/apt/lists/*  
  
USER foundation  
WORKDIR /home/foundation  

