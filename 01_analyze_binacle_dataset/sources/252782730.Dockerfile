FROM davedoesdev/rumprun-toolchain-base  
ONBUILD COPY rumprun /rumprun  
ONBUILD COPY .git /.git  
ONBUILD RUN cd rumprun && ./build-rr.sh hw  
ENV RUMPRUN_TOOLCHAIN_PLATFORM hw  

