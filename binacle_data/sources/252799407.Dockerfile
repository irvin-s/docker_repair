FROM ubuntu:14.04  
MAINTAINER Dennis Hedegaard <dennis@dhedegaard.dk>  
VOLUME /build  
RUN apt-get update -qq && \  
apt-get install -qqy mingw32 && \  
rm -rf /var/lib/apt/lists/*  
ADD mouseclicker.cpp .  
CMD cp mouseclicker.cpp /build && \  
cd /build && \  
i586-mingw32msvc-g++ mouseclicker.cpp -lwinmm -o mouseclicker.exe -g -Wall  

