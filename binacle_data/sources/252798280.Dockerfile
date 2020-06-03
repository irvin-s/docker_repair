FROM ubuntu:14.04.4  
  
RUN apt-get update && apt-get install -y \  
unzip \  
wget \  
nano \  
libxext6 \  
libc6 \  
libfreetype6 \  
libx11-6 \  
libxau6 \  
libxdmcp6 \  
libxinerama1 \  
libcups2 \  
libdbus-glib-1-2 \  
libfontconfig1  
  

