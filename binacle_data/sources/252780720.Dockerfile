FROM multiarch/alpine:x86-v3.3  
MAINTAINER Bruno Adelé "bruno@adele.im"  
# Emulate glibc for running the Go executable  
RUN ln -s /lib/ld-musl-i386.so.1 /lib/ld-linux.so.2  

