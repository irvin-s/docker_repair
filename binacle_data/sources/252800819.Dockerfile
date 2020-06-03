FROM mhart/alpine-node:6  
  
ENV PATH /root/.yarn/bin:$PATH  
  
COPY ./install.sh install.sh  
  
RUN apk update && \  
apk add curl bash binutils tar && \  
rm -rf /var/cache/apk/* && \  
/bin/bash && \  
touch ~/.bashrc && \  
chmod +x install.sh && \  
bash install.sh && \  
apk del curl tar binutils

