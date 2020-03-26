ARG OS  
FROM cangjians/libcangjie:${OS}  
MAINTAINER Cangjians (https://cangjians.github.io)  
  
# basic environment for building  
WORKDIR /usr/local/src/pycangjie  
  
# copy source files to build  
COPY "." "./"  
  
# build the library  
RUN ./autogen.sh --prefix=/usr && \  
make && \  
if grep -q ID_LIKE=debian /usr/lib/os-release; then \  
make install pyexecdir=/usr/lib/python3/dist-packages; \  
else \  
make install; \  
fi  

