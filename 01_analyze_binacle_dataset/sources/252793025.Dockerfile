FROM chibidev/emsdk:latest  
  
ARG version=latest  
ENV SDK_VERSION=sdk-${version}-64bit  
  
RUN ln -sf /bin/bash /bin/sh  
RUN source /emscripten/emsdk_env.sh && \  
emsdk install $SDK_VERSION && \  
emsdk activate $SDK_VERSION && \  
rm /emscripten/zips/*

